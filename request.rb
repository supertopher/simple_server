class Request
  attr_reader :verb, :uri, :http_version
  def initialize header
    @header = header
    # parse_header
    parse_first_line
  end

  # def parse_header
  #   @header = @header.split("\n")
  #   parse_first_line
  # end

  def parse_first_line
    first_line = @header
    first_line = first_line.split(' ')
    @verb         = first_line[0]
    @uri          = first_line[1]
    @http_version = first_line[2]
  end

end