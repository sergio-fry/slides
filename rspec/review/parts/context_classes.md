# Тестовые классы 
3 из 8

---

<!-- header: Тестовые классы 3 из 8 -->

![bg](img/bg/ruby-concurrency.png)

# Анонимные классы 1/2


```ruby
subject do
  Class.new do
    def zero
      nil
    end

    # ...
  end.new
end
                                                              
```
<a class="link--source" href="https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/async_spec.rb">https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/async_spec.rb</a>


---

![bg](img/bg/pg.png)

# Анонимные классы 2/2

```ruby
it "shouldn't accept invalid return from fit_to_copy_get" do
  tm = Class.new(PG::TypeMapInRuby) do
    def fit_to_copy_get
      :invalid
    end
  end.new.freeze

  ce = PG::TextDecoder::CopyRow.new(type_map: tm).freeze
  expect { ce.decode("5\t6\n") }.to raise_error(TypeError, /kind of Integer/)
end

```

<a class="link--source" href="https://github.com/ged/ruby-pg/blob/1c67bb/spec/pg/type_map_in_ruby_spec.rb">https://github.com/ged/ruby-pg/blob/1c67bb/spec/pg/type_map_in_ruby_spec.rb</a>

---

![bg](img/bg/rom-rb.png)

# Классы в модуле 1/3

```ruby
before do
  configuration.relation(:users)
  configuration.relation(:tasks)

  class Test::CreateUser < ROM::Commands::Create[:memory]
    config.component.id = :create
    config.component.namespace = :users
    config.component.relation = :users
    config.result = :one
  end
end
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/suite/rom/commands/create_spec.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/suite/rom/commands/create_spec.rb</a>

---

![bg](img/bg/dry-rb.png)

# Классы в модуле 2/3

```ruby
it 'raises no error when all monads are loaded' do
  expect do
    class Test::MyClass
      include Dry::Monads
    end
  end.not_to raise_error

  expect(Test::MyClass.constants).to include(:Success)
  expect(Test::MyClass.constants).to include(:Failure)
end
```

<a class="link--source" href="https://github.com/dry-rb/dry-monads/blob/704c1b/spec/integration/all_monads_inclusion_spec.rb">https://github.com/dry-rb/dry-monads/blob/704c1b/spec/integration/all_monads_inclusion_spec.rb</a>


---

![bg](img/bg/rom-rb.png)

# Классы в модуле 3/3

```ruby
module Test
  def self.remove_constants
    constants.each(&method(:remove_const))
  end
end

config.after do
  gateway.disconnect if respond_to?(:gateway)
    && gateway.respond_to?(:disconnect)
  Test.remove_constants
end
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/spec_helper.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/spec_helper.rb</a>


---


<!-- header: "" -->
