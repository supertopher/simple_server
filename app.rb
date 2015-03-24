$LOAD_PATH.unshift(File.expand_path('.'))
require 'socket'
# require 'views'
require 'routes'
require 'base'
require 'byebug'

Signal.trap("INT") {
  puts
  puts "Shutting down server"
  exit
}

server = TCPServer.new 2000

class Response
  def initialize args = {}
    @http_version   = args[:http_version]   ||= "HTTP/1.1"
    @response_code  = args[:response_code]  ||= "200"
    @server         = args[:server]         ||= "Topherserve/.0.0.1 (BSD) (OSX)"
    @content_type   = args[:content_type]   ||= "text/html; charset=UTF-8"
    @connection     = args[:connection]     ||= "close"
    # @time           = Time.now.gmtime # Syntax Check this
  end

  def headers
"#{@http_version}
Server: #{@server}
Content-Type: #{@content_type}
Connection: #{@connection}

"
  end
end

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
    p body
  else
    response              = Response.new({ :http_version => request_http_version,
    :response_code => 404 })
    puts "hill"
  end
  client.puts response.headers + body
  client.close
end
