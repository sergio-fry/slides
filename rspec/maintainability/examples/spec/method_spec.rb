RSpec.describe "def method" do
  def post(*_args) = nil
  def make_request = post :create, params: { id: 1, title: "New title" }
  let(:response) { double(:response, success?: true) }

  it do
    make_request
    expect(response).to be_success
  end
end
