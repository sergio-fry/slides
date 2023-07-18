RSpec.describe 'doubl example' do
  let(:user) { double(:user, name: "Ivan") }
  it { expect(user.name).to eq "Ivan" }
end
