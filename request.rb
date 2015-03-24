require 'cgi'

class Request
  attr_reader :verb, :uri, :http_version, :query, :params
  def initialize header
    @header = header
    # parse_header
    parse_first_line
    parse_uri
  end

  # def parse_header
  #   @header = @header.split("\n")
  #   parse_first_line
  # end

  def parse_first_line
    first_line = @header.take(1)[0].split(' ')
    @verb         = first_line[0]
    @uri          = first_line[1]
    @http_version = first_line[2]
  end

  def parse_uri
    @uri, params = @uri.split("?") if @uri.include?('?')
    @params = {}
    params.split("&").each do |param_string|
      key, value = param_string.split("=")
      @params[key] = value
    end
    puts "Params yo #{@params}"

    # @params = CGI::parse(params)
    # p @params
  end

end