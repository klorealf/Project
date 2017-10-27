module GeniusApi
  def request(type="get", endpoint="", query_string="")
    token_uri = URI.parse("https://api.genius.com/" + endpoint)
    https = Net::HTTP.new(token_uri.host, token_uri.port)
    https.use_ssl = true
    http_type_class
    if type == "get"
      http_type_class = Net::HTTP::Get
    elsif type == "post"
      http_type_class = Net::HTTP::Post
    end

    request = http_type_class.new(token_uri.path + query_string)

    # fyi the following line is doing this:
    # request['Authorization'] = 'Basic ' + Base64.encode64(CLIENT_ID + ':' + CLIENT_SECRET)
    request['Authorization'] = 'Bearer ' + ENV["GENIUS_CLIENT_TOKEN"]
    # request.set_form_data('grant_type' => 'client_credentials')
    response = https.request(request)
    p JSON.parse(response.body)
  end

  def self.search(song_name)
    escaped_query = URI.escape(song_name)
    request('get', 'search', '?q=' + escaped_query)
  end

  def self.get_song(song_id)
    request('get', "songs/#{song_id}" )
  end

  def self.parse_artist_search(json_body)
  end
end
