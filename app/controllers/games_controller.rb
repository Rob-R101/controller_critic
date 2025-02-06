class GamesController < ApplicationController
  def index
    if params[:query].present?
      # Normalize the query to handle abbreviations like 'ps4' and 'ps5'
      normalized_query = normalize_query(params[:query])

      # Use the search_games scope and order alphabetically by title
      @games = Game.search_games(normalized_query).reorder(:title)

      # Flash message if no games are found
      flash.now[:alert] = "No games found for '#{params[:query]}'" if @games.empty?
    else
      # Order all games alphabetically if no query is provided
      @games = Game.all.order(:title)
    end
  end

  def show
    @game = Game.find(params[:id])

    # Check user authentication and retrieve related data
    if user_signed_in?
      @user_game = current_user.my_games.find_by(game: @game)
      @user_wishlist = current_user.wishlists.find_by(game: @game)
    else
      @user_game = nil
      @user_wishlist = nil
    end

     # Fetch and limit reviews to 10, sorting by vote count descending
  @reviews = @game.reviews
  .order(Arel.sql('COALESCE(count, 0) DESC'))
  .limit(7)
end




  private

  # Method to normalize the query for known abbreviations
  def normalize_query(query)
    query = query.downcase
    query.gsub!("ps5", "playstation 5")
    query.gsub!("ps4", "playstation 4")
    query.gsub!("ps3", "playstation 3")
    query.gsub!("ps2", "playstation 2")
    query
  end
end


  # def fetch_access_token
  #   response = HTTParty.post('https://id.twitch.tv/oauth2/token', body: {
  #     client_id: 'k3ioyb8xalvwsor0mq4765aywu1z18',
  #     client_secret: 'r7sjqn613wfxiv1p7w58zzf2w0lzi2',
  #     grant_type: 'client_credentials'
  #   })

  #   response.success? ? response['access_token'] : nil
  # end

  # def fetch_igdb_games(query, access_token)
  #   response = HTTParty.post('https://api.igdb.com/v4/games',
  #     headers: {
  #       'Client-ID' => 'k3ioyb8xalvwsor0mq4765aywu1z18',
  #       'Authorization' => "Bearer #{access_token}",
  #       'Content-Type' => 'application/json'
  #     },
  #     body: "search \"#{query}\"; fields name, summary, rating, genres.name, cover.url; limit 10;"
  #   )

  #   if response.success?
  #     JSON.parse(response.body)
  #   else
  #     Rails.logger.error "IGDB API Error: #{response.body}"
  #     []
  #   end
  # end
