# Конфигурация
1 из 8

---

<!-- header: Конфигурация 1 из 8 -->

![bg](img/bg/gitlab.png)

# helper конфиг 1/2

- spec_helper
- fast_spec_helper
- rake_helper
- rubocop_spec_helper

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec</a>

---

![bg](img/bg/gitlab.png)

# helper конфиг 2/2

```ruby
RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{spec/rubocop}) do |metadata|
    metadata[:type] = :rubocop
  end

  config.include RuboCop::RSpec::ExpectOffense, type: :rubocop
  config.include_context 'config', type: :rubocop
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/rubocop_spec_helper.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/rubocop_spec_helper.rb</a>

---

![bg](img/bg/pg.png)

# Tags

```ruby
it 'should tell about pipeline mode', :postgresql_14 do
  @conn.enter_pipeline_mode
  expect(@conn.inspect).to match(/ pipeline_status=PQ_PIPELINE_ON/)
end
```

<a class="link--source" href="https://github.com/ged/ruby-pg/blob/1c67bb/spec/pg/connection_spec.rb">https://github.com/ged/ruby-pg/blob/1c67bb/spec/pg/connection_spec.rb</a>


---

![bg](img/warning.png)

```ruby
# TODO: each spec file should require its dependencies.
# Maybe we'll get there one day
require "rom"
require "rom/sql"
require "rom/memory"
require "rom/repository"
require "rom/changeset"
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/spec_helper.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/spec_helper.rb</a>

---

![bg](img/bg/rom-rb.png)

# Определение группы


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

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/spec_helper.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/spec_helper.rb</a>


---

![bg](img/bg/rom-rb.png)

# Helper 1/3

```ruby
RSpec.describe ROM::SQL::Associations::ManyToMany, helpers: true do
```
<a class="link--source" href="https://github.com/rom-rb/rom-sql/blob/beb115/spec/integration/associations/many_to_many_spec.rb">https://github.com/rom-rb/rom-sql/blob/beb115/spec/integration/associations/many_to_many_spec.rb</a>

---

![bg](img/bg/rom-rb.png)

# Helper 2/3

```ruby
config.include(Helpers, helpers: true)
```

<a class="link--source" href="https://github.com/rom-rb/rom-sql/blob/beb115/spec/spec_helper.rb">https://github.com/rom-rb/rom-sql/blob/beb115/spec/spec_helper.rb</a>

---

![bg](img/warning.png)

# Helper 3/3


```ruby
Dir[root.join("shared/**/*.rb")].sort.each { |f| require f }
Dir[root.join("support/**/*.rb")].sort.each { |f| require f }
```

<a class="link--source" href="https://github.com/rom-rb/rom-sql/blob/beb115/spec/spec_helper.rb">https://github.com/rom-rb/rom-sql/blob/beb115/spec/spec_helper.rb</a>

---

![bg](img/bg/rspec.png)

# Sandboxed

```ruby
RSpec.configure do |c|
  c.around do |ex|
    RSpec::Core::Sandbox.sandboxed do |config|
      # If there is an example-within-an-example,
      # we want to make sure the inner example
      # does not get a reference to the outer example
      # (the real spec) if it calls
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

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/support/sandboxing.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/support/sandboxing.rb</a>

---

![bg](img/bg/dry-rb.png)

```ruby
require "warning"

Warning.ignore(%r{rspec/core})
Warning.ignore(%r{rspec/mocks})
Warning.ignore(/codacy/)
Warning[:experimental] = false if Warning.respond_to?(:[])
```

<a class="link--source" href="https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb">https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb</a>

---

<!-- header: "" -->
