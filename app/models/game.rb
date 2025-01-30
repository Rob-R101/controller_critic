class Game < ApplicationRecord
  has_many :reviews
  has_many :my_games
  has_many :player_users, through: :my_games, source: :user

  has_many :wishlists
  has_many :wished_users, through: :wishlists, source: :user

  has_many :game_platforms
  has_many :platforms, through: :game_platforms

  include PgSearch::Model
  pg_search_scope :search_games,
  against: [ :title, :developer, :genre, :year_published, :publisher ],
  using: {
    tsearch: { prefix: true }
  }

end
