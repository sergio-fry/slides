require 'lib/cached_stats'

RSpec.describe 'double example' do
  subject { CachedStats.new(cache:) }

  let(:cache) { double(:cache, get: 123) }

  it { expect(subject.count).to eq 123 }
end
