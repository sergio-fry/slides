RSpec.describe 'test1' do
  one = 1

  random_number = rand
  it { expect(one).to eq 1 }

  it { expect(random_number).to eq 1 }
  it { expect(random_number).to eq 1 }
end
