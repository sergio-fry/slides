require 'lib/cache' # dependency
require 'lib/cached_stats'

RSpec.describe 'verifining double example' do
  subject { CachedStats.new(cache:) }

  let(:cache) { instance_double(Cache, get: 123) }

  it { expect(subject.count).to eq 123 }
end
