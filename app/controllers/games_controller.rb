class GamesController < ApplicationController

  def index
    if params[:query].present?
      @games = Game.search_games(params[:query])
      flash.now[:alert] = "No games found for '#{params[:query]}'" if @games.empty?
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
    @reviews = @game.reviews.order(created_at: :desc)
  end

end
