class Platform < ApplicationRecord
  has_many :game_platforms
  has_many :games, through: :game_platforms
  has_many :user_platforms
  has_many :users, through: :user_platforms
end
