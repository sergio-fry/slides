# Контекст

---

<!-- header: Контекст -->

```
▾ fixtures/
  ▾ app/persistence/
    ▸ commands/
    ▸ mappers/
    ▸ my_commands/
    ▸ my_mappers/
    ▸ my_relations/
    ▸ relations/
  ▾ auto_loading/
    ▾ app/
      ▸ commands/users/
      ▸ mappers/
      ▸ relations/
    ▸ persistence/
```

rom-rb

---

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

```ruby
RSpec.shared_context 'changeset / database' do
  include_context 'changeset / database setup'

  before do
    %i[tags tasks books posts_labels posts users labels
       reactions messages].each { |table| conn.drop_table?(table) }

    conn.create_table :users do
      primary_key :id
      column :name, String
    end

    conn.create_table :books do
      primary_key :id
      foreign_key :author_id, :users, on_delete: :cascade
      column :title, String
      column :created_at, Time
      column :updated_at, Time
    end
  end
end
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/shared/rom/changeset/database.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/shared/rom/changeset/database.rb</a>


---


```ruby
context 'when used in combination with the BisectDRbFormatter', :slow do
  include FormatterSupport

  attr_reader :server

  around do |ex|
    Bisect::Server.run do |the_server|
      @server = the_server
      ex.run
    end
  end

  def run_formatter_specs
    RSpec.configuration.drb_port = server.drb_port
    run_rspec_with_formatter('bisect-drb')
  end

  it 'receives suite results' do
    results = server.capture_run_results(['spec/rspec/core/resources/formatter_specs.rb']) do
    end
  end
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/bisect/server_spec.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/bisect/server_spec.rb</a>


---




```ruby
def without_env_vars(*vars)
  original = ENV.to_hash
  vars.each { |k| ENV.delete(k) }

  begin
    yield
  ensure
    ENV.replace(original)
  end
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/spec_helper.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/spec_helper.rb</a>


```ruby
with_env_vars 'XDG_CONFIG_HOME' => '~/.custom-config' do
  options = parse_options
  expect(options[:formatters]).to eq([['overridden_xdg']])
end

without_env_vars 'XDG_CONFIG_HOME' do
  options = parse_options
  expect(options[:formatters]).to eq([['default_xdg']])
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/configuration_options_spec.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/configuration_options_spec.rb</a>


---

```ruby
RSpec.describe JavaSingleThreadExecutor, type: :jruby do
  after(:each) do
    subject.shutdown
    expect(subject.wait_for_termination(pool_termination_timeout)).to eq true
  end

  subject { JavaSingleThreadExecutor.new }

  it_should_behave_like :executor_service
end
```

<a class="link--source" href="https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b9/spec/concurrent/executor/java_single_thread_executor_spec.rb">concurrent-ruby/blob/1982b9/spec/concurrent/executor/java_single_thread_executor_spec.rb</a>

---

```ruby
allow(config).to receive(:logger).and_return(double.as_null_object)
```

<a class="link--source" href="https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette/http_interaction_list_spec.rb">https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette/http_interaction_list_spec.rb</a>

---


```ruby
describe 'clean_outdated_http_interactions' do
  before(:each) do
    subject.instance_variable_set(:@clean_outdated_http_interactions, true)
    subject.instance_variable_set(:@previously_recorded_interactions,
                                  subject.instance_variable_get(:@new_recorded_interactions))
    subject.instance_variable_set(:@new_recorded_interactions, [])
  end
end
```

<a class="link--source" href="https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette_spec.rb">https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette_spec.rb</a>

---

```ruby
def passing_example(fail_if_no_examples)
  "
    RSpec.configure { |c| c.fail_if_no_examples = #{fail_if_no_examples} }

    RSpec.describe 'something' do
      it 'succeeds' do
        true
      end
    end
  "
end

it 'succeeds if fail_if_no_examples set to true' do
  write_file 'spec/example_spec.rb', passing_example(true)
  run_command ''
  expect(last_cmd_stdout).to include('1 example, 0 failures')
  expect(last_cmd_exit_status).to eq(0)
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/integration/fail_if_no_examples_spec.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/integration/fail_if_no_examples_spec.rb</a>

---

<!-- header: "" -->
