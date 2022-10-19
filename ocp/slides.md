---

paginate: true
class: lead
marp: true
---
<style>
  section {
  }
  h1,body,li,p { color: black; }

  h1 {
    text-decoration: underline;
    text-decoration-color: #FF5028;
    text-underline-offset: 0.3em;
    text-decoration-thickness: 0.1em;
    padding-bottom: 0.3em;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-width: 90%;
  }
</style>
<!--
_paginate: false
_class: lead
-->

# Принцип открытости/закрытости

---

# Формулировка 1

Modules should be open for extension and closed for modification

---

# Формулировка 2
You should be able to extend a classes behavior, without modifying it

---

# Формулировка 3

You should be able to extend the behavior of a system without having to modify that system.

---

```plantuml

package "Shop gem" {
  class Product {
    +price()
  }
}

```

---

# Наследование

```plantuml
package "Shop gem" {
  class Product {
    +price()
  }
}

class ProductWithBonusPrice {
  +price()
}

ProductWithBonusPrice -up-|> Product
```

---

# Стоит избегать

* monkey patching
* переопределения методов

---

# Dependecy Injection

```plantuml
package "Shop gem" {
  class Product {
    +price()
  }
  interface Price {
    +value()
  }
}

Product --* Price

class BonusPrice {
  +value()
}

BonusPrice ..|> Price
```

---

```ruby
# gem
class Product
  def initialize(price:)
    @price = price
  end

  def price
    @price.value
  end
end
```

---

```ruby
# app
class BonusPrice
  def initialize(user:, base_value:)
    @user = user
    @base_value = base_value
  end

  def value
    if user.lucky?
      @base_value * 0.9
    else
      @base_value
    end
  end
end

product = Product.new(price: BonusPrice.new(user, 10.0))
product.price
```

---

# Что если нужно внедрить расширение несколько раз?

---

# History

* large gem
* extract core
* extend with modules

---

# In a Wild

---

[x] Rack
[ ] ActiveJob
[ ] Faraday
[ ] Logger
[ ] Jekyll
[ ] Warden
[ ] Enumerable
[ ] Redmine

---

# Rack

---
<!-- header: Rack -->

```ruby
class Middleware
  def initialize(app)
    @app = app
  end

  def call(env)
    env["rack.some_header"] = "setting an example"
    @app.call(env)
  end
end

use Middleware
run lambda { |env| [200, { "content-type" => "text/plain" }, ["OK"]] }
```

---

```ruby
def use(middleware, *args, &block)
  # ...
  @use << proc { |app| middleware.new(app, *args, &block) }
end
```

```ruby
def to_app
  # ..
  app = @use.reverse.inject(app) { |a, e| e[a].tap { |x| x.freeze if @freeze_app } }
  @warmup.call(app) if @warmup
  app
end
```

---

<!-- header: "" -->

---

# ActiveJob

```ruby
class MyJob < ActiveJob::Base
  queue_as :my_jobs

  def perform(record)
    record.do_work
  end
end
```

---

<!-- header: ActiveJob -->

```ruby
class InlineAdapter
  def enqueue(job) # :nodoc:
    Base.execute(job.serialize)
  end

  def enqueue_at(*) # :nodoc:
    raise NotImplementedError, "Use a queueing backend to enqueue jobs in the future. Read more at https://guides.rubyonrails.org/active_job_basics.html"
  end
end

ActiveJob::Base.queue_adapter = :inline
```

---

```ruby

module ActiveJob
  module Execution
    # Includes methods for executing and performing jobs instantly.
    module ClassMethods
      def perform_now(...)
        job_or_instantiate(...).perform_now
      end

      def execute(job_data) # :nodoc:
        ActiveJob::Callbacks.run_callbacks(:execute) do
        job = deserialize(job_data)
        job.perform_now
      end
    end
  end
end
```

---

# Итоги

* точки расширения
* middleware
* callbacks
* не все OCP

---

# Tips

* `.call`
* ActiveSupport Load Hooks

---

# Материалы

* https://blog.cleancoder.com/uncle-bob/2014/05/12/TheOpenClosedPrinciple.html
