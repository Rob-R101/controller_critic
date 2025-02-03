require 'httparty'

namespace :igdb do
  desc "Fetches the Twitch access token"
  task get_access_token: :environment do
    response = HTTParty.post('https://id.twitch.tv/oauth2/token', body: {
    client_id: 'k3ioyb8xalvwsor0mq4765aywu1z18',
    client_secret: 'r7sjqn613wfxiv1p7w58zzf2w0lzi2',
    grant_type: 'client_credentials'
    })


    if response.success?
      puts "Access Token: #{response['access_token']}"
    else
      puts "Error fetching token: #{response.body}"
    end
  end
end
