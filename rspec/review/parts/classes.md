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

https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/integration/all_monads_inclusion_spec.rb#L16C1-L25C6


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

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/suite/rom/commands/create_spec.rb

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
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/async_spec.rb#L78-L85


