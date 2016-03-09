require 'json'
require 'sinatra/base'

class App < Sinatra::Base
  set :port, 8080

  post '/init' do
    ''
  end

  post '/run' do
    content_type :json

    request.body.rewind
    params = JSON.parse request.body.read
    name = params.dig('value', 'name') || 'world'
    JSON.dump({'result' => {'msg' => "Hello, #{name}"}})
  end
end

App.run!
