class CreateUserplatforms < ActiveRecord::Migration[7.1]
  def change
    create_table :userplatforms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
