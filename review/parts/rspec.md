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
end```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/support/sandboxing.rb

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
      run_command ""
      expect(last_cmd_stdout).to include("1 example, 0 failures")
      expect(last_cmd_exit_status).to eq(0)
    end
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/integration/fail_if_no_examples_spec.rb

```ruby

      expect(DRb).not_to have_running_server

      expect {
        Bisect::Server.run do
          expect(DRb).to have_running_server
          raise "boom"
        end
      }.to raise_error("boom")
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/rspec/core/bisect/server_spec.rb


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

```ruby

    [
      ["--failure-exit-code", "3", :failure_exit_code, 3 ],
      ["--pattern", "foo/bar", :pattern, "foo/bar"],
      ["--failure-exit-code", "37", :failure_exit_code, 37],
      ["--default-path", "behavior", :default_path, "behavior"],
      ["--order", "rand", :order, "rand"],
      ["--seed", "37", :order, "rand:37"],
      ["--drb-port", "37", :drb_port, 37]
    ].each do |cli_option, cli_value, config_key, config_value|
      it "forces #{config_key}" do
        opts = config_options_object(cli_option, cli_value)
        expect(config).to receive(:force) do |pair|
          expect(pair.keys.first).to eq(config_key)
          expect(pair.values.first).to eq(config_value)
        end
        opts.configure(config)
      end
    end
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/rspec/core/configuration_options_spec.rb


```ruby

    def expect_parsing_to_fail_mentioning_source(source, options=[])
      expect {
        parse_options(*options)
      }.to raise_error(SystemExit).and output(a_string_including(
        "invalid option: --foo_bar (defined in #{source})",
        "Please use --help for a listing of valid options"
      )).to_stderr
    end

    context "defined in $XDG_CONFIG_HOME/rspec/options" do
      it "mentions the file name in the error so users know where to look for it" do
        file_name = File.expand_path("~/.config/rspec/options")
        create_fixture_file(file_name, "--foo_bar")
        expect_parsing_to_fail_mentioning_source(file_name)
      end
    end
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/rspec/core/configuration_options_spec.rb


