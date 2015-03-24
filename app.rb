$LOAD_PATH.unshift(File.expand_path('.'))
require 'socket'
require 'routes'
require 'response'
require 'request'

Signal.trap("INT") {
  puts
  puts "Shutting down server"
  exit
}

server = TCPServer.new 2000

loop do
  client                = server.accept
  request               = Request.new client.gets.chomp
  body                  = ""
  if Router.valid_route?(request.uri)
    response              = Response.new({ :http_version => request.http_version })
    safe_url = (/(\w+)/).match(request.uri)
    view_method = View.method(safe_url.to_s)
    puts "here"
    body = view_method.call
  else
    response              = Response.new({ :http_version => request.http_version,
    :response_code => "404 Not Found" })
    body = "Resource Not Found"
  end
  client.puts response.headers + body
  client.close
end
