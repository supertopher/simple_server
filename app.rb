$LOAD_PATH.unshift(File.expand_path('.'))
require 'socket'
require 'views'

Signal.trap("INT") {
  puts
  puts "shutting down server"
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

response = Response.new

puts response.headers
puts View.welcome

loop do
  client = server.accept
  client.gets
  client.puts response.headers + View.welcome
  client.close
end
