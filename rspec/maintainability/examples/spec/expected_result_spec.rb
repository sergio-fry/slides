RSpec.describe "expected result" do
  let(:user) { double(:user, id: 1) }
  let(:expected) { { status: "ok", id: user.id, content_type: "application/json" } }
  let(:response) { { status: "ok", id: user.id, content_type: "application/json" } }

  it { expect(response).to eq expected }

  it { expect(response).to include(status: "ok") }
  it { expect(response).to include(id: user.id) }
end
