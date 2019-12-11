# Modaular ruby app


---


# Module

```ruby
module HTTPRequest
  def get(url, query={})
    Faraday.get url, query, { "Authorization": "Bearer #{ENV["TOKEN"]}" }
  end
end
```

---

# Module Usage

```ruby
class UsersRequest
  include HTTPRequest

  def call
    get 'http://example.com/api/users', page: 1
  end
end
```

---

```ruby
module HTTPRequest
  def get(url, query={})
    @resp = Faraday.get url, query, headers
  end

  private

  def headers
    { "Authorization": "Bearer #{ENV["TOKEN"]}" }
  end
end
```
