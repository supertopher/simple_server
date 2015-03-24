$LOAD_PATH.unshift(File.expand_path('.'))
require 'routes'
require 'response'
require 'request'
require 'server'
require 'routes'

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


server.listen!