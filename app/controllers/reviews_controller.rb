class ReviewsController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    @reviews = @game.reviews
  end
end
