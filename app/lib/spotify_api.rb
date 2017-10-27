module SpotifyAPI
  def self.authenticate
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end

  def self.get_top_tracks_names(search_term)
    spotify_results = RSpotify::Artist.search(search_term)
    # assumes top artist in artist search is desired artist
    spotify_results[0].top_tracks(:US).map(&:name)
  end
end
