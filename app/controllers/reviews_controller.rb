class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :upvote, :downvote]
  before_action :set_game
  before_action :set_review, only: [:upvote, :downvote]


  def upvote
    @review.increment!(:count)

    respond_to do |format|
      format.html { redirect_to game_path(@game, anchor: "review-#{@review.id}"), notice: "You upvoted the review!" }
      format.turbo_stream
    end
  end

  def downvote
    if @review.count.to_i > 0
      @review.decrement!(:count)
      flash[:notice] = "You downvoted the review!"
    else
      flash[:alert] = "Cannot downvote below 0."
    end

    respond_to do |format|
      format.html { redirect_to game_path(@game, anchor: "review-#{@review.id}") }
      format.turbo_stream
    end
  end

  def create
    @review = @game.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Review added successfully.'
      redirect_to game_path(@game, anchor: "review-#{@review.id}")
    else
      # Fetch reviews and handle sorting to display on the show page
      @reviews = @game.reviews.order(count: :desc)

      # Render the game's show page with errors displayed
      flash.now[:alert] = @review.errors.full_messages.join(", ")
      render "games/show"
    end
  end


  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_review
    @review = @game.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:review)
  end
end
