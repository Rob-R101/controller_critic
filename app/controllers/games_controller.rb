class GamesController < ApplicationController
  require 'httparty'

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

  private

  # def fetch_access_token
  #   response = HTTParty.post('https://id.twitch.tv/oauth2/token', body: {
  #     client_id: 'k3ioyb8xalvwsor0mq4765aywu1z18',
  #     client_secret: 'r7sjqn613wfxiv1p7w58zzf2w0lzi2',
  #     grant_type: 'client_credentials'
  #   })

  #   response.success? ? response['access_token'] : nil
  # end

  # def fetch_igdb_games(query, access_token)
  #   response = HTTParty.post('https://api.igdb.com/v4/games',
  #     headers: {
  #       'Client-ID' => 'k3ioyb8xalvwsor0mq4765aywu1z18',
  #       'Authorization' => "Bearer #{access_token}",
  #       'Content-Type' => 'application/json'
  #     },
  #     body: "search \"#{query}\"; fields name, summary, rating, genres.name, cover.url; limit 10;"
  #   )

  #   if response.success?
  #     JSON.parse(response.body)
  #   else
  #     Rails.logger.error "IGDB API Error: #{response.body}"
  #     []
  #   end
  # end
end
