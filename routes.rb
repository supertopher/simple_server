require 'views'
class Router
  def self.valid_route? url
    url = (/(\w+)/).match(url)
    puts url.to_s
    View.respond_to? url.to_s
  end

end