```ruby
  it "raises no error when all monads are loaded" do
    expect {
      class Test::MyClass
        include Dry::Monads
      end
    }.not_to raise_error

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
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/suite/rom/commands/create_spec.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/suite/rom/commands/create_spec.rb</a>

---



```ruby
      subject do
        Class.new {
          def zero() nil; end
          def three(a, b, c, &block) nil; end
          def two_plus_two(a, b, c=nil, d=nil, &block) nil; end
          def many(*args, &block) nil; end
        }.new
      end
```
<a class="link--source" href="https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/async_spec.rb">https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/async_spec.rb</a>


---
