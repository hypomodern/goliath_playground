#!/usr/bin/env ruby
# encoding: utf-8
$:<< '.'

require 'bundler/setup'
require 'goliath'
require 'em-synchrony/em-http'
require 'em-http/middleware/json_response'
require 'regular_json'
require 'streaming_json'

# automatically parse the JSON HTTP response
EM::HttpRequest.use EventMachine::Middleware::JSONResponse

#
# Our router. Two routes only.
class Router < Goliath::API
  # some goliath middleware: parsing the query response and formatting the JSON output
  # N.B. this middleware *must* be inserted here, rather than in the actual endpoint classes.
  #  Hopefully, that will change soon, because that's not cool.
  use Goliath::Rack::Params
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render

  map '/streaming/json' do
    run StreamingJSON.new
  end

  map '/regular/json' do
    run RegularJSON.new
  end

  map '/' do
    run Proc.new { |env|
      [200, { 'Content-Type' => 'text/html' }, [
        <<-RESPONSE
<!DOCTYPE html>
<html>
<body>
  <h1>Goliath Experiments!</h1>
  <p>There are json api endpoints defined at the following paths:</p>
  <ul>
    <li><a href="/streaming/json">/streaming/json</a> &ndash; A streaming endpoint. Try curl or an EM client with YAJL.</li>
    <li><a href="/regular/json">/regular/json</a> &ndash; A regular JSON producer.</li>
    <li>Both paths take a url parameter, "q", which will be used to query github's JSON api.</li>
  </ul>

  <p>Thanks to @igrigorik, @ryandaigle, and the Heroku people for making this easy and fun to play with!</p>
</body>
</html>
        RESPONSE
      ]]
    }
  end

end