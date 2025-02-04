class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question

    # Request AI response
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai
      }
    )

    # Extract response content
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    # Log the response for debugging
    Rails.logger.info "AI Response Content: #{new_content}"

    # Update the question with the AI response
    question.update(ai_answer: new_content)

    # Broadcast updated response to the frontend
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question",
      locals: { question: question }
    )
  end

  def nearest_games
    # Get embedding for the user's question
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )

    # Use the embedding to find nearest games
    question_embedding = response['data'][0]['embedding']
    Game.nearest_neighbors(:embedding, question_embedding, distance: "euclidean")
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []

    # Define system prompt with link instructions
    system_text = <<~TEXT
      You are an assistant for a video game recommendation app.
        - When providing gae information, include a clickable link putting the games ID at the end of this
        a tags href attribute and the game name as the a tag value,
        like this : <a href='http://localhost:3000/games/(insert the id of the game here)'> game(insert the game title here). <a/>
        Here are all the games' titles, id and descriptions.
    TEXT


    # Add game details to the system prompt
    nearest_games.each do |game|
      game_url = Rails.application.routes.url_helpers.game_path(game)
      system_text += "id: #{game.id}, title: #{game.title}, description: #{game.description}\n"
    end

    # Log the system prompt for debugging
    Rails.logger.info "System Prompt for AI: #{system_text}"

    # Add system message to the conversation
    results << { role: "system", content: system_text }

    # Add previous user questions and AI responses
    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    results
  end
end
