# Goliath for asynchronous processing and streaming API services

## Why?

I'm curious and I want to play. Also [Heroku Cedar](http://devcenter.heroku.com/articles/cedar) is an efficient pathway to deploying this kind of code, since it works out of the box.

## Goal

A goliath router that returns interesting, well-formed JSON from two endpoints: one streaming, one not. Firefox is, I think, the only browser that supports streamed responses at the moment, but non-browser clients (e.g. cURL, Node.js, other Eventmachine-backed Ruby services) should be able to consume streamed JSON just fine. If you're on ruby, check out yajl-ruby. If you're on node.js, you can either parse it yourself or use yajl-js. Check it out: [YAJL](http://lloyd.github.com/yajl/), [DIY help](http://stackoverflow.com/questions/5771914/nodejs-parsing-chunked-twitter-json).

Maybe we'll get websockets going and be able to stream to a websocket someday :).

## HOWTO

* `bundle install`
* You can run this puppy with `bundle exec ruby router.rb -sv -e prod -p $PORT`
* play around with curl, e.g. curl http://localhost:$PORT
* or with a modern browser (FF4+, newish Chrome) you can check out the streaming action in the browser!
* visit the root page to get a quick overview and relevant links.

Heroku's new Cedar stack supports all of these toys, too.

### A Tip of the Hat to:

* Ilya Grigorik, natch. His [blog post](http://www.igvita.com/2011/06/02/0-60-deploying-goliath-on-heroku-cedar/?utm_source=feedburner&utm_campaign=Feed%3A+igvita+%28igvita.com%29&utm_content=feed) was the inspiration.
* Heroku, for the Cedar stack.