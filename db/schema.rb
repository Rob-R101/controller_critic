# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_01_31_093558) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_platforms", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "platform_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_platforms_on_game_id"
    t.index ["platform_id"], name: "index_game_platforms_on_platform_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.string "developer"
    t.string "genre"
    t.decimal "rating"
    t.integer "year_published"
    t.string "publisher"
    t.string "website"
    t.string "product_image"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "my_games", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_my_games_on_game_id"
    t.index ["user_id"], name: "index_my_games_on_user_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "review"
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_reviews_on_game_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "userplatforms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "platform_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_userplatforms_on_platform_id"
    t.index ["user_id"], name: "index_userplatforms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "profile_picture_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_wishlists_on_game_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "game_platforms", "games"
  add_foreign_key "game_platforms", "platforms"
  add_foreign_key "my_games", "games"
  add_foreign_key "my_games", "users"
  add_foreign_key "reviews", "games"
  add_foreign_key "reviews", "users"
  add_foreign_key "userplatforms", "platforms"
  add_foreign_key "userplatforms", "users"
  add_foreign_key "wishlists", "games"
  add_foreign_key "wishlists", "users"
end
