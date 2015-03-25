$LOAD_PATH.unshift(File.expand_path('.'))
require 'response'
require 'request'
require 'server'
require 'erb'

Signal.trap("INT") {
  puts
  puts "Shutting down server"
  exit
}

server = Server.new

server.get '/' do |request|
  server.erb :index, request
end

server.get '/welcome' do |request|
  server.erb :welcome, request
end


server.listen!