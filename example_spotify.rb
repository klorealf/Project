require "net/http"
require "uri"
require "base64"
require 'json'

# these creds are obtained from Spotify by creating an account and a new application
# keep these creds secret!
# thus these creds would live in configuration variables ENV['VARIABLE_NAME'], etc.
CLIENT_ID = ENV['SPOTIFY_CLIENT_ID']
CLIENT_SECRET = ENV['SPOTIFY_CLIENT_SECRET']

token_uri = URI.parse("https://accounts.spotify.com/api/token")
https = Net::HTTP.new(token_uri.host, token_uri.port)
https.use_ssl = true
request = Net::HTTP::Post.new(token_uri.path)

# fyi the following line is doing this:
# request['Authorization'] = 'Basic ' + Base64.encode64(CLIENT_ID + ':' + CLIENT_SECRET)
request.basic_auth(CLIENT_ID, CLIENT_SECRET)

request.set_form_data('grant_type' => 'client_credentials')
response = https.request(request)
p JSON.parse(response.body)
