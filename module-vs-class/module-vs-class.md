---
@auto-scale: true
paginate: true
---

# Module vs Class

Sergei O. Udalov

---

# How to extend?

* include module
* inherit from base class

---

# Include Module

```ruby
class UsersRequest
  include HTTPRequest
end
```

---

# Class Inheritance

```ruby
class UsersRequest < HTTPRequest
end
```

---
<!-- footer: Module -->

# Module Example

```ruby
module HTTPRequest
  def http_get(url, options={})
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
    http_get 'http://example.com/api/users', page: 1
  end
end
```

---

# Incapsulation

```ruby
module HTTPRequest
  def http_get(url, query={}, headers={})
    Faraday.get url, query, headers
  end

  private

  def headers
    { "Authorization": "Bearer #{ENV["TOKEN"]}" }
  end
end
```

---

# Incapsulation is Broken!

```ruby
module UsersRequest
  include HTTPRequest

  def call
    http_get 'http://example.com/api/users', page: 1
  end

  private

  def headers
    { "Authorization": "Bearer #{ENV["TOKEN"]}" }
  end
end
```
