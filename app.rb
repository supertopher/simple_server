$LOAD_PATH.unshift(File.expand_path('.'))
require 'routes'
require 'response'
require 'request'
require 'server'

Signal.trap("INT") {
  puts
  puts "Shutting down server"
  exit
}

server = Server.new

server.listen!
