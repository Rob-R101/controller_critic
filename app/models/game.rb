class Game < ApplicationRecord
  has_many :reviews
  has_many :my_games
  has_many :player_users, through: :my_games, source: :user

  has_many :wishlists
  has_many :wished_users, through: :wishlists, source: :user

  has_many :game_platforms
  has_many :platforms, through: :game_platforms

  has_neighbors :embedding
  after_create :set_embedding

  include PgSearch::Model

  # Update the pg_search_scope to include relevant fields for searching
  pg_search_scope :search_games,
    against: [ :title, :developer, :genre, :year_published, :publisher ],
    associated_against: {
      platforms: :name  # Allow searches by platform names if needed
    },
    using: {
      tsearch: { prefix: true }  # Allows partial matches (e.g., "Fan" for "Fantasy")
    }

    private

    def set_embedding
      client = OpenAI::Client.new
      response = client.embeddings(
        parameters: {
          model: 'text-embedding-3-small',
          input: "Game: #{title}. Description: #{description}"
        }
      )
      embedding = response['data'][0]['embedding']
      update(embedding: embedding)
    end
end
