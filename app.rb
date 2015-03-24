$LOAD_PATH.unshift(File.expand_path('.'))
require 'socket'
require 'routes'
require 'response'

Signal.trap("INT") {
  puts
  puts "Shutting down server"
  exit
}

server = TCPServer.new 2000

loop do
  client                = server.accept
  request               = client.gets.chomp
  request_headers       = request.split(' ')
  request_verb          = request_headers[0]
  request_url           = request_headers[1]
  request_http_version  = request_headers[2]
  body                  = ""
  if Router.valid_route?(request_url)
    response              = Response.new({ :http_version => request_http_version })
    safe_url = (/(\w+)/).match(request_url)
    view_method = View.method(safe_url.to_s)
    puts "here"
    body = view_method.call
  else
    response              = Response.new({ :http_version => request_http_version,
    :response_code => "404 Not Found" })
    body = "Resource Not Found"
  end
  client.puts response.headers + body
  client.close
end
