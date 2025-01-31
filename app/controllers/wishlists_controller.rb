class WishlistsController < ApplicationController

  def index
    @wishlists = current_user.wishlist.includes(:games)
  end

  def create
    @game = Game.find(params[:game_id])
    wishlist = Wishlist.new(game: @game, user: current_user)

    if wishlist.save
      redirect_to game_path(@game), notice: "Game added to your wishlist."
    else
      redirect_to game_path(@game), alert: "Unable to add to your wishlist."
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy
    redirect_back fallback_location: root_path, notice: "Game removed from Wishlist."
  end

end
