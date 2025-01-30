class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @wishlist = @user.wishlists
    @mygames = @user.games
    @reviews = @user.reviews #add to routes
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully"
    else
      flash.now[:alert] = "There was a problem updating your profile."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
