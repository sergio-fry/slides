```ruby

FactoryBot.define do
  factory :user, aliases: [:author, :assignee, :recipient, :owner, :resource_owner] do
    email { generate(:email) }
    name { generate(:name) }
    # ..
  end
end
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/factories/users.rb#L4


---

```ruby
def textdec_timestamptz_decode_should_fail(str)
  expect(textdec_timestamptz.decode(str)).to eq(str)
end

it 'fails when the timestamp is an empty string' do
  textdec_timestamptz_decode_should_fail('')
end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_spec.rb


---




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


---



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

