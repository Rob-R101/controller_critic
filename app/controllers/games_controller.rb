class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @reviews = @game.reviews.order(created_at: :desc)
  end

end
