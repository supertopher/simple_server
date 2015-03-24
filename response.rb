class Response
  def initialize args = {}
    @http_version   = args[:http_version]   ||= "HTTP/1.1"
    @response_code  = args[:response_code]  ||= "200 OK"
    @server         = args[:server]         ||= "Topherserve/.0.0.1 (BSD) (OSX)"
    @content_type   = args[:content_type]   ||= "text/html; charset=UTF-8"
    @connection     = args[:connection]     ||= "close"
    # @time           = Time.now.gmtime # Syntax Check this
  end

  def headers
"#{@http_version} #{@response_code}
Server: #{@server}
Content-Type: #{@content_type}
Connection: #{@connection}

"
  end
end