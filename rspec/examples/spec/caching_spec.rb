RSpec.describe 'caching' do
  context 'when caching disabled', caching: false do
    it  { expect(1).to eq 3 }
  end

  context 'when caching enabled', caching: true do
    it  { expect(1).to eq 2 }
  end
end
