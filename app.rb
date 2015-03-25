$LOAD_PATH.unshift(File.expand_path('.'))
require 'routes'
require 'response'
require 'request'
require 'server'
require 'routes'
require 'erb'

Signal.trap("INT") {
  puts
  puts "Shutting down server"
  exit
}

server = Server.new

server.get '/' do |request|
  if request.params.key? "name"
    "Hello there #{request.params["name"]}"
  else
    "Hello Topherserv World"
  end
end

server.get '/welcome' do |request|
  server.erb :index, request
end


server.listen!