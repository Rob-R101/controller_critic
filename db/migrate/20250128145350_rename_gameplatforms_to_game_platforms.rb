class RenameGameplatformsToGamePlatforms < ActiveRecord::Migration[7.0]
  def change
    rename_table :gameplatforms, :game_platforms
  end
end
