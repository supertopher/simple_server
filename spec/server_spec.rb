$LOAD_PATH.unshift(File.expand_path('.'))
require 'server'

describe "#server" do
  let(:client){ StringIO.new("GET /welcome HTTP/1.1\nUser-Agent: curl/7.37.1\nHost: 127.0.0.1:2000\nAccept: */*\n\n\n")}

  it "should get the entire header array" do
    expect(Server.new.get_header_array client).to eq(["GET /welcome HTTP/1.1", "User-Agent: curl/7.37.1", "Host: 127.0.0.1:2000", "Accept: */*", ""])
  end

end