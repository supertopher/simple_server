$LOAD_PATH.unshift(File.expand_path('.'))
require 'response'

describe "#response" do
  it "should provide a proper 200 OK response by default" do
    expect(Response.new.headers).to eq("HTTP/1.1 200 OK\nServer: Topherserve/.0.0.1 (BSD) (OSX)\nContent-Type: text/html; charset=UTF-8\nConnection: close\n\n")
  end

  it "should change response code to 404 when called with that argument" do
    expect(Response.new(response_code: "404 Page Not Found").headers).to eq("HTTP/1.1 404 Page Not Found\nServer: Topherserve/.0.0.1 (BSD) (OSX)\nContent-Type: text/html; charset=UTF-8\nConnection: close\n\n")
  end

end