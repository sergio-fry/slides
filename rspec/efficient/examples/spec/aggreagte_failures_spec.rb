class Response
  def initialize(body:, headers:, status:)
    @body = body
    @headers = headers
    @status = status
  end

  def [](key)
    @headers[key]
  end

  attr_reader :status
end

class Internet
  def get(_url)
    Response.new(
      headers: { 'x-time' => 0.2 },
      body: 'hello world',
      status: 201
    )
  end
end

RSpec.describe 'Aggregate Failures' do
  describe 'Response' do
    let(:response) { Internet.new.get('http://example.com/test') }

    it { expect(response['x-time'].to_f).to be < 0.1 }
    it { expect(response.status).to eq 200 }
  end

  describe 'Response aggregate', :aggregate_failures do
    let(:response) { Internet.new.get('http://example.com/test') }

    it {
      expect(response['x-time'].to_f).to be < 0.1
      expect(response.status).to eq 200
    }
  end

  describe 'Response aggregate block' do
    let(:response) { Internet.new.get('http://example.com/test') }

    it {
      expect(response.status).to eq 200

      aggregate_failures do
        expect(response['x-time'].to_f).to be < 0.1
        expect(response['content-type']).to eq 'application/json'
      end
    }
  end
end
