
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
			expect{ ce.decode("5\t6\n") }.to raise_error(TypeError, /kind of Integer/)
		end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_map_in_ruby_spec.rb

---

```ruby
RSpec.shared_context "changeset / database" do
  include_context "changeset / database setup"

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
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/shared/rom/changeset/database.rb


---


```ruby

    context "when used in combination with the BisectDRbFormatter", :slow do
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
        run_rspec_with_formatter("bisect-drb")
      end

      it 'receives suite results' do
        results = server.capture_run_results(['spec/rspec/core/resources/formatter_specs.rb']) do
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/rspec/core/bisect/server_spec.rb


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

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/spec_helper.rb


```ruby

      with_env_vars 'XDG_CONFIG_HOME' => "~/.custom-config" do
        options = parse_options()
        expect(options[:formatters]).to eq([['overridden_xdg']])
      end

      without_env_vars 'XDG_CONFIG_HOME' do
        options = parse_options()
        expect(options[:formatters]).to eq([['default_xdg']])
      end
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/rspec/core/configuration_options_spec.rb


---

```ruby
RSpec.describe JavaSingleThreadExecutor, :type=>:jruby do

      after(:each) do
        subject.shutdown
        expect(subject.wait_for_termination(pool_termination_timeout)).to eq true
      end

      subject { JavaSingleThreadExecutor.new }

      it_should_behave_like :executor_service
    end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/executor/java_single_thread_executor_spec.rb#L8
