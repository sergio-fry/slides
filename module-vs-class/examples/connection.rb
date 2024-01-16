class Products
  def all
    http_get("https://example.com/api/products")
  end

  def request(url, q: {})
    JSON.parse(Faraday.get(url, query(q)))
  end

  def query(q)
    { token: ENV["TOKEN"] }.merge(q)
  end
end

###########################################

class Products
  include HTTPRequest

  def all
    http_get("https://example.com/api/products")
  end
end

module HTTPRequest
  def request(url, q: {})
    JSON.parse(Faraday.get(url, query(q)))
  end

  def query(q)
    { token: ENV["TOKEN"] }.merge(q)
  end
end
