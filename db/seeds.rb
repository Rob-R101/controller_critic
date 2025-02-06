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
Question.destroy_all
User.destroy_all

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
    game["platforms"].each do |platform_data|
      platform_name = platform_data["name"]

      # Find or create the platform
      platform = find_or_create_platform(platform_name)

      # Create the game-platform association
      GamePlatform.create!(game: new_game, platform: platform)
    end
  else
    puts "No platforms found for #{game['name']}."
  end
end

# Fetch all games from the database for later use
games = Game.all

# Create Users with profile pictures
users = 10.times.map do
  username = Faker::Internet.unique.username(specifier: 5..12) # Generate a unique username
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    username: username,
    profile_picture_url: "https://api.dicebear.com/7.x/bottts-neutral/png?seed=#{username}"
  ).tap do |user|
    puts "Created user: #{user.username} (#{user.email})"
  end
end

# Predefined review comments
review_comments = [
  "Loved this game! Played it for hours and couldn't put it down. The storyline was captivating and kept me hooked from start to finish.",
  "Highly recommended for any fan of the genre. The mechanics were smooth, and the character development was surprisingly deep and satisfying.",
  "The game was just okay...graphics were a bit sub-par in my opinion. The pacing felt off at times, but it had a few moments that redeemed it.",
  "Amazing graphics and gameplay! This gets 10/10 all day. The open world is beautifully crafted, and there are endless activities to explore.",
  "Not what I expected, to be honest. The trailers gave a very different impression, and while the game had potential, it ultimately fell short.",
  "Would play again! The gameplay loop is incredibly addictive, and I found myself constantly trying new strategies to complete objectives.",
  "Very immersive experience with an engaging atmosphere. The attention to detail in the world-building made every corner feel alive and full of secrets.",
  "Too short but enjoyable nonetheless. I finished the main campaign in a weekend, but the replay value makes up for its brevity.",
  "Had some bugs but overall good. There were a few crashes and visual glitches, but nothing that ruined the experience entirely.",
  "Great multiplayer experience! Coordinating with friends added so much fun, and the competitive modes are well-designed for hours of gameplay.",
  "Highly recommended! The story is emotional, and the characters feel so real that I was completely invested in their journey.",
  "Avoid at all costs. The game is riddled with technical issues, and I could barely get through the first few missions without running into problems.",
  "Play this now! It's one of the best games I've ever experienced, and I guarantee you'll be talking about it for weeks after finishing it."
]


# Ensure each game has at least one review
reviews = games.map do |game|
  Review.create!(
    user: users.sample,
    game: game,
    review: review_comments.sample
  ).tap { |review| puts "Created review for game: #{game.title}" }
end

# Create additional random reviews
(random_reviews = 750 - games.count).times do
  reviews << Review.create!(
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
