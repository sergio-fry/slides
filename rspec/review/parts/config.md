

# ls spec/*_helper.rb

- spec_helper
- fast_spec_helper
- rake_helper
- rubocop_spec_helper


```ruby
RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{spec/rubocop}) do |metadata|
    metadata[:type] = :rubocop
  end

  config.include RuboCop::RSpec::ExpectOffense, type: :rubocop
  config.include_context 'config', type: :rubocop
end
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/rubocop_spec_helper.rb#L14C1-L29C4

---

```ruby

		it "should tell about pipeline mode", :postgresql_14 do
			@conn.enter_pipeline_mode
			expect( @conn.inspect ).to match(/ pipeline_status=PQ_PIPELINE_ON/)
		end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/connection_spec.rb


---


```ruby

# TODO: each spec file should require its dependencies. Maybe we'll get there one day
require "rom"
require "rom/sql"
require "rom/memory"
require "rom/repository"
require "rom/changeset"
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb

---



```ruby

module Test
  def self.remove_constants
    constants.each(&method(:remove_const))
  end
end

  config.after do
    gateway.disconnect if respond_to?(:gateway) && gateway.respond_to?(:disconnect)
    Test.remove_constants
  end
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb


---



```ruby

  config.define_derived_metadata file_path: %r{/suite/} do |metadata|
    metadata[:group] = metadata[:file_path]
      .split("/")
      .then { |parts| parts[parts.index("suite") + 1] }
      .to_sym
  end

  %i[rom compat].each do |group|
    config.when_first_matching_example_defined group: group do
      require_relative "support/#{group}"
    end
  end
```


https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb


---




```ruby

RSpec.describe ROM::SQL::Associations::ManyToMany, helpers: true do

```
https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/integration/associations/many_to_many_spec.rb

```ruby
  config.include(Helpers, helpers: true)
```

https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb

```ruby
  Dir[root.join("shared/**/*.rb")].sort.each { |f| require f }
  Dir[root.join("support/**/*.rb")].sort.each { |f| require f }
```

https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb
