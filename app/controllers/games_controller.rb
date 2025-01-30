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
    if user_signed_in?
      @user_game = current_user.my_games.find_by(game: @game)
      @user_wishlist = current_user.wishlists.find_by(game: @game)
    else
      @user_game = nil
      @user_wishlist = nil
    end
    @reviews = @game.reviews.order(created_at: :desc)
  end

end
