class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_review, only: [:upvote, :downvote]

  def upvote
    @review.increment!(:count)
    redirect_back fallback_location: game_path(@review.game), notice: 'Review upvoted.'
  end

  def downvote
    @review.decrement!(:count)
    redirect_back fallback_location: game_path(@review.game), notice: 'Review downvoted.'
  end

  def index
    @game = Game.find(params[:game_id])
    @reviews = @game.reviews.order(created_at: :desc)
  end

  def create
    @game = Game.find(params[:game_id])
    @review = @game.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_back fallback_location: game_path(@game), notice: 'Review added successfully.'
    else
      redirect_back fallback_location: game_path(@game), alert: 'Unable to add review.'
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:review)
  end
end
