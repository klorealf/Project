get "/" do
  redirect "/spotify/search"
end

get "/spotify/search" do
  @testdata = RSpotify::Artist.search('Arctic Monkeys')
  erb :"spotify/search"
end

get '/spotify/results' do
  # I wrote a SpotifyAPI module, it's in the lib folder in this repo
  SpotifyAPI.authenticate
  @top_tracks_names = SpotifyAPI.get_top_tracks_names(params[:search_input])

  erb :'spotify/results'
end

