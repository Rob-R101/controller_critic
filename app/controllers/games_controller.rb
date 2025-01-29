class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    # @gameplatform = Gameplatform.find(params[:id])
  end

end
