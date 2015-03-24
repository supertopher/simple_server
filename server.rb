require 'socket'

class Server
  def initialize port = 2000
    @server = TCPServer.new port
    @routes = { "get" => {}, "post" => {} }
  end

  def listen!
    loop do
      client                = @server.accept
      header_array          = get_header_array client
      request               = Request.new header_array
      build_response request, client
      client.close
    end
  end

  def get_header_array client
    request_array         = []
    while request_array.last != ""
      request_array << client.gets.chomp
    end
    request_array
  end

  def build_response request, client
    request_route = @routes[request.verb.downcase][request.uri]
    if request_route
      response              = Response.new({ :http_version => request.http_version })
      body = request_route.call(request)
    else
      response              = Response.new({ :http_version => request.http_version,
        :response_code => "404 Not Found" })
      body = "Resource Not Found"
    end
    client.puts response.headers + body
  end

  def get(uri, &block)
    @routes["get"][uri] = block
  end


end
