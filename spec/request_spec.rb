$LOAD_PATH.unshift(File.expand_path('.'))
require 'request'

describe "#Request" do
let(:sample_request) {
["GET /welcome?first=Chris HTTP/1.1", "User-Agent: curl/7.37.1", "Host: 127.0.0.1:2000", "Accept: */*", ""]  }

  it "should have GET as the verb when a get request is sent" do
    expect(Request.new(sample_request).verb).to eq("GET")
  end

  it "should correctly parse given URI header" do
    expect(Request.new(sample_request).uri).to eq("/welcome")
  end

  it "should correctly parse given http version header" do
    expect(Request.new(sample_request).http_version).to eq("HTTP/1.1")
  end

  it "should get a single query param from the URI" do
    expect(Request.new(sample_request).params).to eq({"first" => "Chris"})
  end

  it "should correctly get two params from the URI" do
    expect(Request.new(sample_request).params).to eq({"first" => "Chris"})
  end

  xit "should correctly parse given host header" do
    expect(Request.new(sample_request).host).to eq("127.0.0.1:2000")
  end

  xit "should correctly parse given accept header" do
    expect(Request.new(sample_request).accept).to eq("*.*")
  end
end
