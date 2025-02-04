class AddEmbeddingToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :embedding, :vector, limit: 1536
  end
end
