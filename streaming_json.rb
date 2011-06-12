# encoding: utf-8
class StreamingJSON < Goliath::API

  def response env
    # Once again, we're going to query github for our data. That kinda defeats the point, but hey,
    #  this is happy fun demo time :).
    response = nil # set up a dummy variable
    query = params['q'] || 'rack'
    http = EM::HttpRequest.new("http://github.com/api/v2/json/repos/search/#{query}").get

    logger.info "Got a #{http.response_header.status}"
    github = http.response

    repos = github['repositories']
    logger.info "Got #{repos.count} repos"

    # fake some lengthy work (~100ms) to get a response, then put it on the wire
    encoder = Yajl::Encoder.new
    timer = EM.add_periodic_timer(0.1) do
      repo_data = repos.pop
      if repo_data
        env.stream_send("#{encoder.encode(repo_data)}\n")
      else
        timer.cancel
        env.stream_send( '{ "stream": "closed" }' )
        env.logger.info "Closing stream."
        env.stream_close
      end
    end

    [200, { 'Content-Type' => 'application/json' }, Goliath::Response::STREAMING]
  end

end