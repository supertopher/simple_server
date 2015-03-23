require 'socket'

Signal.trap("INT") {
  puts
  puts "shutting down server"
  exit
}

server = TCPServer.new 2000
def response
  create_header
end

class Header
  def initialize args = {}
    @http_version   = args[:http_version]   ||= "HTTP/1.1"
    @response_code  = args[:response_code]  ||= "200"
    @server         = args[:server]         ||= "Topherserve/.0.0.1 (BSD) (OSX)"
    @content_type   = args[:content_type]   ||= "text/html; charset=UTF-8"
    @connection     = args[:connection]     ||= "close"
    # @time           = Time.now.gmtime # Syntax Check this
  end

  def response
    "#{@http_version}
    Server: #{@server}
    Content-Type: #{@content_type}
    Connection: #{@connection}

    "
  end
end

header = Header.new
body =
"
<html>
  <head>
    <title>Super Title</title>
  </head>
  <body>
    Hello World!!
  </body>
</html>"

loop do
  client = server.accept
  client.puts header.response + body
  client.close
end
