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



```ruby
it "returns a new instance" do
  expect(none).to eql(None())
  expect(none.trace).to include("spec/integration/maybe_spec.rb:9:in `block")
end
```
https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/integration/maybe_spec.rb#L17C1-L20C10



```ruby
RSpec.describe(Dry::Monads) do
  let(:m) { described_class }
  list = Dry::Monads::List

  it "builds a list with List[]" do
    expect(instance.make_list).to eql(list[1, 2, 3])
  end
end
```

https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/integration/monads_spec.rb#L5



```ruby
require "warning"

Warning.ignore(%r{rspec/core})
Warning.ignore(%r{rspec/mocks})
Warning.ignore(/codacy/)
Warning[:experimental] = false if Warning.respond_to?(:[])
```
https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/support/warnings.rb#L5C1-L10C59



```ruby
  division_error = 1 / 0 rescue $ERROR_INFO
  no_method_error = no_method rescue $ERROR_INFO
```

https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/unit/try_spec.rb#L19C1-L20C49
