class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @wishlists = @user.wishlists
    @mygames = @user.my_games.includes(:game)

    # Paginate reviews (10 per page)
    @reviews = @user.reviews.order(created_at: :desc).page(params[:page]).per(10)

    # Correct way to get the most popular genre
    @top_genre = @mygames.joins(:game)
                         .group("games.genre")
                         .order(Arel.sql("COUNT(games.id) DESC"))
                         .count
                         .keys
                         .first
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
