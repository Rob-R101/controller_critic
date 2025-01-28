# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing data in the correct order
Review.destroy_all
MyGame.destroy_all
Wishlist.destroy_all
GamePlatform.destroy_all
Platform.destroy_all
Game.destroy_all
User.destroy_all


# Create Platforms
platforms = %w[PC Xbox PS5 Switch].map do |platform_name|
  Platform.create!(name: platform_name)
end

# Create Games
games = 20.times.map do
  Game.create!(
    title: Faker::Game.title,
    developer: Faker::Company.name,
    genre: Faker::Game.genre,
    rating: rand(1.0..5.0).round(1),
    year_published: rand(2000..2025),
    publisher: Faker::Company.name,
    website: Faker::Internet.url,
    youtube_url: "https://www.youtube.com/watch?v=#{Faker::Alphanumeric.alphanumeric(number: 11)}"
  )
end

# Assign each game to 1-3 platforms
games.each do |game|
  platforms.sample(rand(1..3)).each do |platform|
    GamePlatform.create!(game: game, platform: platform)
  end
end

# Create Users
users = 10.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password', # Set a common password for simplicity
    password_confirmation: 'password'
  )
end

# Create Reviews
30.times do
  Review.create!(
    user: users.sample,
    game: games.sample,
    review: Faker::Lorem.paragraph(sentence_count: 5)
  )
end

# Add Games to "My Games" for each user
users.each do |user|
  games.sample(rand(3..7)).each do |game|
    MyGame.create!(user: user, game: game)
  end
end

# Add Games to Wishlists for each user
users.each do |user|
  games.sample(rand(2..5)).each do |game|
    Wishlist.create!(user: user, game: game)
  end
end

puts "Seeded database with:
- #{User.count} users
- #{Game.count} games
- #{Platform.count} platforms
- #{GamePlatform.count} game-platform associations
- #{Review.count} reviews
- #{MyGame.count} 'My Games' entries
- #{Wishlist.count} wishlist entries"
