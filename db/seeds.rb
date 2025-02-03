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

# # Clear existing data in the correct order
Review.destroy_all
MyGame.destroy_all
Wishlist.destroy_all
GamePlatform.destroy_all
Platform.destroy_all
Game.destroy_all
# User.destroy_all

# # Create Platforms
# platforms = %w[PC Xbox PS5 Switch].map do |platform_name|
#   Platform.create!(name: platform_name)
# end

# # Hardcoded game data (20 games)
# real_games = [
#   {
#     title: "Fortnite",
#     developer: "Epic Games",
#     genre: "Battle Royale",
#     rating: 4.5,
#     year_published: 2017,
#     publisher: "Epic Games",
#     website: "https://www.epicgames.com/fortnite",
#     youtube_url: "https://www.youtube.com/watch?v=2gUtfBmw86Y",
#     description: "A globally popular online multiplayer game with a battle royale mode, where players compete to be the last one standing in an ever-shrinking arena.",
#     product_image: "https://assets.xboxservices.com/assets/20/38/203850f5-1bed-4912-b25f-193ee890c97f.jpg?n=Fortnite_GLP-Page-Hero-1084_876951_1920x1080.jpg"
#   },
#   {
#     title: "The Witcher 3: Wild Hunt",
#     developer: "CD Projekt Red",
#     genre: "RPG",
#     rating: 4.9,
#     year_published: 2015,
#     publisher: "CD Projekt",
#     website: "https://thewitcher.com/en/witcher3",
#     youtube_url: "https://www.youtube.com/watch?v=c0i88t0Kacs",
#     description: "An open-world RPG where players take on the role of Geralt of Rivia, a monster hunter navigating a war-torn world filled with intrigue and magic.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/292030/header.jpg?t=1689029909"
#   },
#   {
#     title: "Elden Ring",
#     developer: "FromSoftware",
#     genre: "Action RPG",
#     rating: 4.8,
#     year_published: 2022,
#     publisher: "Bandai Namco Entertainment",
#     website: "https://www.eldenring.com",
#     youtube_url: "https://www.youtube.com/watch?v=E3Huy2cdih0",
#     description: "An action RPG set in a vast, interconnected world filled with challenging foes, secrets, and lore created in collaboration with George R.R. Martin.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg?t=1675084887"
#   },
#   {
#     title: "Cyberpunk 2077",
#     developer: "CD Projekt Red",
#     genre: "Action RPG",
#     rating: 4.2,
#     year_published: 2020,
#     publisher: "CD Projekt",
#     website: "https://www.cyberpunk.net",
#     youtube_url: "https://www.youtube.com/watch?v=FknHjl7eQ6o",
#     description: "A futuristic open-world RPG set in Night City, a dystopian metropolis filled with advanced technology, crime, and corruption.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg?t=1689003937"
#   },
#   {
#     title: "Red Dead Redemption 2",
#     developer: "Rockstar Games",
#     genre: "Action-Adventure",
#     rating: 4.9,
#     year_published: 2018,
#     publisher: "Rockstar Games",
#     website: "https://www.rockstargames.com/reddeadredemption2",
#     youtube_url: "https://www.youtube.com/watch?v=eaW0tYpxyp0",
#     description: "An epic tale of life in America at the dawn of the modern age, following Arthur Morgan and the Van der Linde gang on their quest for survival.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1174180/header.jpg?t=1671485005"
#   },
#   {
#     title: "Horizon Zero Dawn",
#     developer: "Guerrilla Games",
#     genre: "Action RPG",
#     rating: 4.6,
#     year_published: 2017,
#     publisher: "Sony Interactive Entertainment",
#     website: "https://www.guerrilla-games.com/play/horizon",
#     youtube_url: "https://www.youtube.com/watch?v=wzx96gYA8ek",
#     description: "An action RPG set in a post-apocalyptic world where players control Aloy, a young hunter fighting robotic creatures and uncovering secrets of the past.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1151640/header.jpg?t=1689011647"
#   },
#   {
#     title: "God of War (2018)",
#     developer: "Santa Monica Studio",
#     genre: "Action-Adventure",
#     rating: 4.9,
#     year_published: 2018,
#     publisher: "Sony Interactive Entertainment",
#     website: "https://www.playstation.com/en-us/games/god-of-war/",
#     youtube_url: "https://www.youtube.com/watch?v=K0u_kAWLJOA",
#     description: "A reimagining of the God of War series, where players control Kratos and his son Atreus as they embark on a journey through Norse mythology.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1593500/header.jpg?t=1674822865"
#   },
#   {
#     title: "Assassin's Creed Valhalla",
#     developer: "Ubisoft",
#     genre: "Action RPG",
#     rating: 4.3,
#     year_published: 2020,
#     publisher: "Ubisoft",
#     website: "https://www.ubisoft.com/game/assassins-creed/valhalla",
#     youtube_url: "https://www.youtube.com/watch?v=ssrNcwxALS4",
#     description: "Players take on the role of Eivor, a Viking warrior, exploring and conquering England in the ninth century.",
#     product_image: "https://cdn.akamai.steamstatic.com/steam/apps/2208920/header.jpg?t=1679477645"
#   },
#   {
#     title: "Overwatch 2",
#     developer: "Blizzard Entertainment",
#     genre: "Hero Shooter",
#     rating: 4.0,
#     year_published: 2022,
#     publisher: "Blizzard Entertainment",
#     website: "https://playoverwatch.com",
#     youtube_url: "https://www.youtube.com/watch?v=Rh_yqobDg8k",
#     description: "A team-based hero shooter where players select from a roster of unique characters to compete in fast-paced objective-based matches.",
#     product_image: "https://www.nintendo.com/eu/media/images/10_share_images/games_15/nintendo_switch_download_software_1/2x1_NSwitchDS_Overwatch2_Season6_image1280w.png"
#   },
#   {
#     title: "Minecraft",
#     developer: "Mojang Studios",
#     genre: "Sandbox",
#     rating: 4.7,
#     year_published: 2011,
#     publisher: "Mojang Studios",
#     website: "https://www.minecraft.net",
#     youtube_url: "https://www.youtube.com/watch?v=MmB9b5njVbA",
#     description: "A sandbox game that allows players to build, explore, and survive in a blocky, procedurally-generated world with infinite possibilities.",
#     product_image: "https://www.nintendo.com/eu/media/images/10_share_images/games_15/nintendo_switch_4/2x1_NSwitch_Minecraft_image1600w.jpg"
#   },
#   {
#     title: "Call of Duty: Modern Warfare II",
#     developer: "Infinity Ward",
#     genre: "First-person Shooter",
#     rating: 4.3,
#     year_published: 2022,
#     publisher: "Activision",
#     website: "https://www.callofduty.com",
#     youtube_url: "https://www.youtube.com/watch?v=r72GP1PIZa0",
#     description: "A military-themed first-person shooter featuring intense combat scenarios and multiplayer modes.",
#     product_image: "https://image.api.playstation.com/vulcan/img/rnd/202008/1900/lTSvbByTYMqy6R22teoybKCg.png"
#   },
#   {
#     title: "Stardew Valley",
#     developer: "ConcernedApe",
#     genre: "Simulation",
#     rating: 4.8,
#     year_published: 2016,
#     publisher: "ConcernedApe",
#     website: "https://www.stardewvalley.net",
#     youtube_url: "https://www.youtube.com/watch?v=ot7uXNQskhs",
#     description: "A relaxing farming simulation game where players build their farm, interact with townsfolk, and explore caves.",
#     product_image: "https://i0.wp.com/highschool.latimes.com/wp-content/uploads/2022/01/stardew-valley.jpeg?fit=3840%2C2160&ssl=1"
#   },
#   {
#   title: "Super Mario Odyssey",
#   developer: "Nintendo",
#   genre: "Platformer",
#   rating: 4.9,
#   year_published: 2017,
#   publisher: "Nintendo",
#   website: "https://www.nintendo.com/games/detail/super-mario-odyssey-switch/",
#   youtube_url: "https://www.youtube.com/watch?v=wGQHQc_3ycE",
#   description: "Join Mario and his new friend Cappy on a globe-trotting adventure to save Princess Peach and defeat Bowser in this critically acclaimed platformer.",
#   product_image: "https://assets.nintendo.com/image/upload/f_auto/q_auto/dpr_2.0/c_fill,w_1200/ncom/en_US/games/switch/s/super-mario-odyssey-switch/super-mario-odyssey-switch-hero"
# },
# {
#   title: "Legend of Zelda: Breath of the Wild",
#   developer: "Nintendo",
#   genre: "Action-Adventure",
#   rating: 5.0,
#   year_published: 2017,
#   publisher: "Nintendo",
#   website: "https://www.zelda.com/breath-of-the-wild/",
#   youtube_url: "https://www.youtube.com/watch?v=zw47_q9wbBE",
#   description: "Explore the vast kingdom of Hyrule in this groundbreaking open-world adventure. Solve puzzles, battle enemies, and uncover the mysteries of the world.",
#   product_image: "https://www.nintendo.com/eu/media/images/10_share_images/games_15/wiiu_14/SI_WiiU_TheLegendOfZeldaBreathOfTheWild_image1600w.jpg"
# },
# {
#   title: "Halo Infinite",
#   developer: "343 Industries",
#   genre: "First-person Shooter",
#   rating: 4.4,
#   year_published: 2021,
#   publisher: "Xbox Game Studios",
#   website: "https://www.halowaypoint.com/halo-infinite",
#   youtube_url: "https://www.youtube.com/watch?v=PciHZRPV1n4",
#   description: "Master Chief returns in the next chapter of the iconic Halo series, featuring an expansive open-world campaign and multiplayer battles.",
#   product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1240440/header.jpg?t=1638992154"
# },
# {
#   title: "Among Us",
#   developer: "Innersloth",
#   genre: "Party, Social Deduction",
#   rating: 4.2,
#   year_published: 2018,
#   publisher: "Innersloth",
#   website: "https://www.innersloth.com/gameAmongUs.php",
#   youtube_url: "https://www.youtube.com/watch?v=NSJ4cESNQfE",
#   description: "An online party game of teamwork and betrayal. Work together to complete tasks, but beware of impostors trying to sabotage your mission!",
#   product_image: "https://cdn.akamai.steamstatic.com/steam/apps/945360/header.jpg?t=1680556385"
# },
# {
#   title: "Final Fantasy VII Remake",
#   developer: "Square Enix",
#   genre: "RPG",
#   rating: 4.7,
#   year_published: 2020,
#   publisher: "Square Enix",
#   website: "https://ffvii-remake.square-enix-games.com",
#   youtube_url: "https://www.youtube.com/watch?v=ERgrFVhL-n4",
#   description: "Experience the reimagined classic RPG with stunning graphics, new battle systems, and an expanded story in the city of Midgar.",
#   product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1462040/header.jpg?t=1668552960"
# },
# {
#   title: "Animal Crossing: New Horizons",
#   developer: "Nintendo",
#   genre: "Simulation",
#   rating: 4.9,
#   year_published: 2020,
#   publisher: "Nintendo",
#   website: "https://www.animal-crossing.com/new-horizons/",
#   youtube_url: "https://www.youtube.com/watch?v=_3YNL0OWio0",
#   description: "Build your dream island community, interact with villagers, and enjoy a relaxing life of fishing, bug catching, and decorating in this beloved simulation game.",
#   product_image: "https://assets.nintendo.com/image/upload/f_auto/q_auto/ncom/en_US/games/switch/a/animal-crossing-new-horizons-switch/hero"
# },
# {
#   title: "DOOM Eternal",
#   developer: "id Software",
#   genre: "First-person Shooter",
#   rating: 4.8,
#   year_published: 2020,
#   publisher: "Bethesda Softworks",
#   website: "https://slayersclub.bethesda.net/en/game/doom",
#   youtube_url: "https://www.youtube.com/watch?v=FkklG9MA0vM",
#   description: "Rip and tear through hordes of demons in this fast-paced, adrenaline-fueled shooter, with intense combat and epic boss battles.",
#   product_image: "https://cdn.akamai.steamstatic.com/steam/apps/782330/header.jpg?t=1671484885"
# },
# {
#   title: "Resident Evil Village",
#   developer: "Capcom",
#   genre: "Survival Horror",
#   rating: 4.6,
#   year_published: 2021,
#   publisher: "Capcom",
#   website: "https://www.residentevil.com/village/",
#   youtube_url: "https://www.youtube.com/watch?v=QJXmdY4lVR0",
#   description: "Survive terrifying encounters in a mysterious village as Ethan Winters. Uncover dark secrets and face unimaginable horrors.",
#   product_image: "https://cdn.akamai.steamstatic.com/steam/apps/1196590/header.jpg?t=1670554616"
# }

# ]

response = HTTParty.post('https://api.igdb.com/v4/games',
      headers: {
        'Client-ID' => 'k3ioyb8xalvwsor0mq4765aywu1z18',
        'Authorization' => "Bearer 7dm831buyczr4cti8sn2vgt856ulq4",
        'Content-Type' => 'application/json'
      },
      body: "search \"action\"; fields name, summary, rating, genres.name, cover.url; limit 100;"
    )

game_data = JSON.parse(response.body)
p game_data.first
game_data.each do |game|

  game = Game.new(
    title: game["name"],
    product_image: game.dig("cover", "url")&.gsub("thumb", "1080p"),
    description: game["summary"],
    rating: game["rating"],
    # genre: game["genres"]["name"],
  )
  game.save!
end













# # Create games using the hardcoded data
# games = real_games.map do |game_data|
#   Game.create!(game_data)
# end

# # Assign each game to 1-3 platforms
# games.each do |game|
#   platforms.sample(rand(1..3)).each do |platform|
#     GamePlatform.create!(game: game, platform: platform)
#   end
# end

# # Create Users with profile pictures
# users = 10.times.map do
#   User.create!(
#     email: Faker::Internet.unique.email,
#     password: 'password',
#     password_confirmation: 'password',
#     username: Faker::Internet.unique.username(specifier: 5..12),
#     profile_picture_url: "https://loremflickr.com/320/320/person"
#   )
# end

# # Predefined review comments
# review_comments = [
#   "Loved this game!",
#   "Highly recommended.",
#   "The game was just okay.",
#   "Amazing graphics and gameplay!",
#   "Not what I expected.",
#   "Would play again!",
#   "Very immersive experience.",
#   "Too short but enjoyable.",
#   "Had some bugs but overall good.",
#   "Great multiplayer experience!"
# ]

# # Create Reviews with predefined comments
# 30.times do
#   Review.create!(
#     user: users.sample,
#     game: games.sample,
#     review: review_comments.sample
#   )
# end

# # Add Games to "My Games" for each user
# users.each do |user|
#   games.sample(rand(3..7)).each do |game|
#     MyGame.create!(user: user, game: game)
#   end
# end

# # Add Games to Wishlists for each user
# users.each do |user|
#   games.sample(rand(2..5)).each do |game|
#     Wishlist.create!(user: user, game: game)
#   end
# end

# puts "Seeded database with:
# - #{User.count} users
# - #{Game.count} games
# - #{Platform.count} platforms
# - #{GamePlatform.count} game-platform associations
# - #{Review.count} reviews
# - #{MyGame.count} 'My Games' entries
# - #{Wishlist.count} wishlist entries"
