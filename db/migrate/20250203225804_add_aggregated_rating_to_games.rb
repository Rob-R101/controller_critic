class AddAggregatedRatingToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :aggregated_rating, :float
  end
end
