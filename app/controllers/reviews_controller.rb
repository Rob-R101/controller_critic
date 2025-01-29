class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

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

  def review_params
    params.require(:review).permit(:review)
  end
end
