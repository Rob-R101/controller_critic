class Game < ApplicationRecord
  has_many :reviews
  has_many :my_games
  has_many :users, through: :my_games
  has_many :wishlists
  has_many :wishlist_users, through: :wishlists, source: :user
  has_many :game_platforms
  has_many :platforms, through: :game_platforms
end
