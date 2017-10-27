require "net/http"
require "uri"
require "base64"
require 'json'
require 'pry'

# these creds are obtained from Spotify by creating an account and a new application
# keep these creds secret!
# thus these creds would live in configuration variables ENV['VARIABLE_NAME'], etc.
# CLIENT_ID = ENV['SPOTIFY_CLIENT_ID']
# CLIENT_SECRET = ENV['SPOTIFY_CLIENT_SECRET']
token_uri = URI.parse("https://api.genius.com/search")
https = Net::HTTP.new(token_uri.host, token_uri.port)
https.use_ssl = true
request = Net::HTTP::Get.new(token_uri.path + '?q="rhianna"')

# fyi the following line is doing this:
# request['Authorization'] = 'Basic ' + Base64.encode64(CLIENT_ID + ':' + CLIENT_SECRET)
request['Authorization'] = 'Bearer ' + ENV["GENIUS_CLIENT_TOKEN"]
# request.set_form_data('grant_type' => 'client_credentials')
response = https.request(request)
data = JSON.parse(response.body)
songs = data["response"]["hits"]

songs.each do |song|
  title = song["result"]["full_title"]
  id = song["result"]["id"]
end

binding.pry
puts 'done'
