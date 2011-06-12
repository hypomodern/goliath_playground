# encoding: utf-8
class RegularJSON < Goliath::API
  # if you are defining an endpoint in Goliath (rather than a router), you must def response(env)
  # we're expecting /regular/json?q=my_github_query (if no 'q', we'll use 'rack')
  def response env
    response = nil # set up a dummy variable
    query = params['q'] || 'rack'
    http = EM::HttpRequest.new("http://github.com/api/v2/json/repos/search/#{query}").get

    logger.info "Got a #{http.response_header.status}"
    response = http.response

    if response
      [200, { 'Content-Type' => 'application/json' }, response]
    else
      [500, { 'Content-Type' => 'text/plain' }, ["Something bad happened! #{http.response_header.inspect}"]]
    end
  end

end