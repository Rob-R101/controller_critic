# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'faker'

# Clear existing data in the correct order
Review.destroy_all
MyGame.destroy_all
Wishlist.destroy_all
GamePlatform.destroy_all
Platform.destroy_all
Game.destroy_all

# Fetch top games by aggregated rating from IGDB API
response = HTTParty.post('https://api.igdb.com/v4/games',
  headers: {
    'Client-ID' => ENV['IGDB_CLIENT_ID'],
    'Authorization' => "Bearer #{ENV['IGDB_ACCESS_TOKEN']}",
    'Content-Type' => 'application/json'
  },
  body: <<~QUERY
    fields name, summary, platforms.name, aggregated_rating, rating, genres.name, cover.url, release_dates.date, involved_companies.company.name, involved_companies.publisher;
    where platforms.name = ("PlayStation 5", "PlayStation 4", "PlayStation 3", "PlayStation 2", "Xbox Series X|S", "Xbox One", "Xbox 360", "Nintendo Switch", "Switch", "PC (Microsoft Windows)", "Mac")
      & aggregated_rating != null;
    sort aggregated_rating desc;
    limit 250;
  QUERY
)

game_data = JSON.parse(response.body)
puts "Fetched #{game_data.size} games from API"


# Helper method to find or create platforms
def find_or_create_platform(platform_name)
  Platform.find_or_create_by!(name: platform_name)
end

# Process each game entry from the API
game_data.each do |game|
  puts "Processing game: #{game['name']}"

  # Extract and handle release dates
  release_dates = game["release_dates"]&.map { |release| release["date"] }&.compact
  earliest_release_date = release_dates&.min if release_dates.present?
  year_published = Time.at(earliest_release_date).year if earliest_release_date

  # Extract the publisher name
  publisher_info = game["involved_companies"]&.find { |company| company["publisher"] }
  publisher_name = publisher_info&.dig("company", "name")

  # Create and save the new game object
  new_game = Game.create!(
    title: game["name"],
    product_image: game.dig("cover", "url")&.gsub("thumb", "1080p"),
    description: game["summary"],
    aggregated_rating: game["aggregated_rating"],
    rating: game["rating"],
    genre: game.dig("genres", 0, "name") || "Unknown",
    year_published: year_published,
    publisher: publisher_name
  )

 # Process platforms if available
if game["platforms"]
  puts "Found platforms for #{game['name']}:"
  game["platforms"].each do |platform_data|
    platform_name = platform_data["name"]
    puts "- Processing platform: #{platform_name}"

    # Find or create the platform
    platform = find_or_create_platform(platform_name)

    # Create the game-platform association
    association = GamePlatform.create!(game: new_game, platform: platform)

    puts "-> Created association: Game '#{new_game.title}' <-> Platform '#{platform.name}'"
  end
else
  puts "No platforms found for #{game['name']}."
end


  puts "Saved game: #{new_game.title}"
end

# Fetch all games from the database for later use
games = Game.all

# Create Users with profile pictures
users = 10.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    username: Faker::Internet.unique.username(specifier: 5..12),
    profile_picture_url: "https://loremflickr.com/320/320/person"
  ).tap do |user|
    puts "Created user: #{user.username} (#{user.email})"
  end
end

# Predefined review comments
review_comments = [
  "Loved this game!",
  "Highly recommended.",
  "The game was just okay.",
  "Amazing graphics and gameplay!",
  "Not what I expected.",
  "Would play again!",
  "Very immersive experience.",
  "Too short but enjoyable.",
  "Had some bugs but overall good.",
  "Great multiplayer experience!"
]

# Create Reviews with predefined comments
30.times do
  Review.create!(
    user: users.sample,
    game: games.sample,
    review: review_comments.sample
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

# Final log output
puts "Seeded database with:
- #{User.count} users
- #{Game.count} games
- #{Platform.count} platforms
- #{Review.count} reviews
- #{MyGame.count} 'My Games' entries
- #{Wishlist.count} wishlist entries"
