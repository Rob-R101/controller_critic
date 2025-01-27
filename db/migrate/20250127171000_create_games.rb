class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :developer
      t.string :genre
      t.decimal :rating
      t.integer :year_published
      t.string :publisher
      t.string :website
      t.string :product_image
      t.string :youtube_url

      t.timestamps
    end
  end
end
