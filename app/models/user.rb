class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :my_games
  has_many :games, through: :my_games
  has_many :wishlists
  has_many :games, through: :wishlists
  has_many :user_platforms
  has_many :platforms, through: :user_platforms
end
