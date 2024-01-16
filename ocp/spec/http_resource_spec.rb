require 'net/http'

class HTTPResource
  def initialize(url, retry_policy: ->(code, body) { true })
    @url = url
    @retry_policy = retry_policy
  end

  def body
    make_request
    @body
  end

  def code
    make_request
    @code
  end

  private

  def make_request
    res = Net::HTTP.get_response(URI(@url))
    @code, @body = res.code, res.body
  end
end

RSpec.describe HTTPResource do
  describe do
    let(:resource) { described_class.new url }
    let(:url) { 'https://ya.ru/' }
    it { expect(resource.code).to eq 302 }
  end
end


RSpec.xdescribe HTTPResource do
  describe do
    let(:resource) { described_class.new url }
    let(:url) { 'https://ya.ru/' }
    it { expect(resource.code).to eq 302 }
  end
end
