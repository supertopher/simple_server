class Request
  attr_reader :verb, :uri, :http_version
  def initialize header
    @header = header
    parse_header
  end

  def parse_header
    @header = @header.split("\n")
    parse_first_line
  end

  def parse_first_line
    first_line = @header.take(1)
    first_line = first_line[0].split(' ')
    @verb         = first_line[0]
    @url          = first_line[1]
    @http_version = first_line[2]
  end

end