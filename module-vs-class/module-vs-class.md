---
paginate: true
theme: gaia
---
<style>
  section {
    background: white;
  }
</style>

<!--
_paginate: false
_class: lead
-->


# Module vs Class

Sergei O. Udalov

---


# How to extend?

* include module
* inherit from base class
* composition
* etc

---

# Include Module

```ruby
class UsersRequest
  include HTTPRequest
end
```

---

# Module Example

```ruby
module HTTPRequest
  def http_get(url, q={})
    Faraday.get url, { "api_token": ENV["TOKEN"] }.merge(q)
  end
end

class UsersRequest
  include HTTPRequest

  def call(page)
    http_get 'http://example.com/api/users', { page: page }
  end
end
```

---

# Broken Incapsulation

```ruby
module HTTPRequest
  def http_get(url, q={})
    Faraday.get url, query(q)
  end

  private

  def query(q)
    { "Authorization": "Bearer #{ENV["TOKEN"]}" }.merge(q)
  end
end

module UsersRequest
  include HTTPRequest

  def call(page)
    http_get 'http://example.com/api/users', query(page)
  end

  private

  def query(page) # is already taken
    { page: page }
  end
end
```

---

# Class


```ruby
class HTTPRequest
  def http_get(url, q={})
    Faraday.get url, query(q)
  end

  private

  def query(q)
    { "Authorization": "Bearer #{ENV["TOKEN"]}" }.merge(q)
  end
end
```

---

# Class usage

```ruby
class HTTPRequest
  def http_get(url, q={})
    Faraday.get url, query(q)
  end

  private

  def query(q)
    { "Authorization": "Bearer #{ENV["TOKEN"]}" }.merge(q)
  end
end

module UsersRequest
  def call(page)
    HTTPRequest.new.http_get 'http://example.com/api/users', query(page)
  end

  private

  def query(page)
    { page: page }
  end
end
```
