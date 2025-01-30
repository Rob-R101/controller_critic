class MyGamesController < ApplicationController

  def index
    @my_games = current_user.my_games.includes(:games)
  end

  def create
    @game = Game.find(params[:game_id])
    my_game = MyGame.new(game: @game, user: current_user)

    if my_game.save
      redirect_to game_path(@game), notice: "Game added to your games."
    else
      redirect_to game_path(@game), alert: "Unable to add to your games."
    end

    # Test this when user page set up - should delete from user profile page
    # def destroy
    #   my_game = current_user.my_game.find(params[:id])

    #   if my_game.destroy
    #     redirect_to user_path, notice: "Game removed from my games."
    #   else
    #     redirect_to user_path, alert: "Failed to remove game from my games."
    #   end
    # end
end
