
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

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/rubocop_spec_helper.rb#L14C1-L29C4">https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/rubocop_spec_helper.rb#L14C1-L29C4</a>

---

```ruby
it 'should tell about pipeline mode', :postgresql_14 do
  @conn.enter_pipeline_mode
  expect(@conn.inspect).to match(/ pipeline_status=PQ_PIPELINE_ON/)
end
```

<a class="link--source" href="https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/connection_spec.rb">https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/connection_spec.rb</a>


---


```ruby
# TODO: each spec file should require its dependencies. Maybe we'll get there one day
require "rom"
require "rom/sql"
require "rom/memory"
require "rom/repository"
require "rom/changeset"
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb">https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb</a>

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

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb">https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb</a>


---



```ruby
config.define_derived_metadata file_path: %r{/suite/} do |metadata|
  metadata[:group] = metadata[:file_path]
                     .split('/')
                     .then { |parts| parts[parts.index('suite') + 1] }
                     .to_sym
end

%i[rom compat].each do |group|
  config.when_first_matching_example_defined group: group do
    require_relative "support/#{group}"
  end
end
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb">https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb</a>


---

# Helper 1/3

```ruby
RSpec.describe ROM::SQL::Associations::ManyToMany, helpers: true do
```
<a class="link--source" href="https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/integration/associations/many_to_many_spec.rb">https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/integration/associations/many_to_many_spec.rb</a>

---

# Helper 2/3

```ruby
config.include(Helpers, helpers: true)
```

<a class="link--source" href="https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb">https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb</a>

---

# Helper 3/3


```ruby
Dir[root.join("shared/**/*.rb")].sort.each { |f| require f }
Dir[root.join("support/**/*.rb")].sort.each { |f| require f }
```

<a class="link--source" href="https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb">https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb</a>

---

# Sanboxed

```ruby
RSpec.configure do |c|
  c.around do |ex|
    RSpec::Core::Sandbox.sandboxed do |config|
      # If there is an example-within-an-example, we want to make sure the inner example
      # does not get a reference to the outer example (the real spec) if it calls
      # something like `pending`
      config.before(:context) { RSpec.current_example = nil }

      config.color_mode = :off

      orig_load_path = $LOAD_PATH.dup
      ex.run
      $LOAD_PATH.replace(orig_load_path)
    end
  end
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/support/sandboxing.rb">https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/support/sandboxing.rb</a>

---
