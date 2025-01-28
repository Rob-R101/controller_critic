class RenameMygamesToMyGames < ActiveRecord::Migration[7.1]
  def change
    rename_table :mygames, :my_games
  end
end
