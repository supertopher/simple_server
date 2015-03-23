require 'socket'

Signal.trap("INT") {
  puts
  puts "shutting down server"
  exit
}

server = TCPServer.new 2000

def parse_input input
  case input
  when "home"
    "Welcome to the Black Sun!"
  when "profile"
    "User: Matt Baker"
  else
    "I don't know what you mean"
  end
end

loop do
  client = server.accept
  client.puts "What can i do for you Lazlo?"
  input = client.gets.chomp
  p input
  client.puts parse_input(input)
  client.close
end
