class Cache
  def initialize
    @data = {}
  end

  def get(key) = @data[key]
  def put(key, value) = @data[key] = value
end
