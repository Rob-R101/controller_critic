class CreateGameplatforms < ActiveRecord::Migration[7.1]
  def change
    create_table :gameplatforms do |t|
      t.references :game, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
