require 'ffaker'

RSpec.describe 'Faker' do
  let(:email) { FFaker::Internet.email }

  it { expect(email).not_to be_empty }
end
