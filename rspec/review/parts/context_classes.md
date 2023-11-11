# Тестовые классы 

---

<!-- header: Тестовые классы  -->

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



```ruby
subject do
  Class.new do
    def zero
      nil
    end

    def three(_a, _b, _c)
      nil
    end

    def two_plus_two(_a, _b, _c = nil, _d = nil)
      nil
    end

    def many(*_args)
      nil
    end
  end.new
end
```
<a class="link--source" href="https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/async_spec.rb">https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/async_spec.rb</a>


---

<!-- header: "" -->
