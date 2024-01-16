class CachedStats
  def initialize(cache:)
    @cache = cache
  end

  def count = @cache.get(:count)
end


