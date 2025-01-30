class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_review, only: [:upvote, :downvote]
  before_action :set_game

  def upvote
    @review = @game.reviews.find(params[:id])
    @review.increment!(:count)
    redirect_to game_path(@game, anchor: "review-#{@review.id}"), notice: "You upvoted the review!"
  end

  def downvote
    @review = @game.reviews.find(params[:id])
    @review.decrement!(:count)
    redirect_to game_path(@game, anchor: "review-#{@review.id}"), alert: "You downvoted the review!"
  end



  def create
    @review = @game.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_back fallback_location: game_path(@game), notice: 'Review added successfully.'
    else
      redirect_back fallback_location: game_path(@game), alert: 'Unable to add review.'
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:review)
  end
end
