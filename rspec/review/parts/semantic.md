# Выразительность
7 из 8

---

<!-- header: Выразительность 7 из 8 -->

![bg](img/bg/gitlab.png)

# Factory Alias

```ruby

FactoryBot.define do
  factory :user, aliases: [:author, :assignee, :recipient,
                           :owner, :resource_owner] do
    email { generate(:email) }
    name { generate(:name) }
    # ..
  end
end
```
<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/factories/users.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/factories/users.rb</a>


---

![bg](img/bg/pg.png)

# Метод с ожиданием 1/2

```ruby
def textdec_timestamptz_decode_should_fail(str)
  expect(textdec_timestamptz.decode(str)).to eq(str)
end

it 'fails when the timestamp is an empty string' do
  textdec_timestamptz_decode_should_fail('')
end
```

<a class="link--source" href="https://github.com/ged/ruby-pg/blob/1c67bb/spec/pg/type_spec.rb">https://github.com/ged/ruby-pg/blob/1c67bb/spec/pg/type_spec.rb</a>


---

![bg](img/bg/rspec.png)

# Метод с ожиданием 2/2


```ruby
def expect_parsing_to_fail_mentioning_source(source, options = [])
  expect do
    parse_options(*options)
  end.to raise_error(SystemExit).and output(a_string_including(
                                              "invalid option: --foo_bar (defined in #{source})",
                                              'Please use --help for a listing of valid options'
                                            )).to_stderr
end

context 'defined in $XDG_CONFIG_HOME/rspec/options' do
  it 'mentions the file name in the error so users know where to look for it' do
    file_name = File.expand_path('~/.config/rspec/options')
    create_fixture_file(file_name, '--foo_bar')
    expect_parsing_to_fail_mentioning_source(file_name)
  end
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/configuration_options_spec.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/configuration_options_spec.rb</a>


---

![bg](img/warning.png)

# Детали реализации


```ruby
[
  ['--failure-exit-code', '3', :failure_exit_code, 3],
  ['--pattern', 'foo/bar', :pattern, 'foo/bar'],
  ['--failure-exit-code', '37', :failure_exit_code, 37],
  ['--default-path', 'behavior', :default_path, 'behavior'],
  ['--order', 'rand', :order, 'rand'],
  ['--seed', '37', :order, 'rand:37'],
  ['--drb-port', '37', :drb_port, 37]
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

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/configuration_options_spec.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/configuration_options_spec.rb</a>


---

![bg](img/bg/gitlab.png)

# rspec-parameterized 1/3

```ruby
where(:dot_com, :request_user_agent, :qa_user_agent, :result) do
  false | 'qa_user_agent' | 'qa_user_agent' | false
  true  | nil             | 'qa_user_agent' | false
  true  | ''              | 'qa_user_agent' | false
  true  | 'qa_user_agent' | ''              | false
  true  | 'qa_user_agent' | nil             | false
  true  | 'qa_user_agent' | 'qa_user_agent' | true
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/d1ad38/spec/lib/gitlab/qa_spec.rb">https://github.com/gitlabhq/gitlabhq/blob/d1ad38/spec/lib/gitlab/qa_spec.rb</a>

---

![bg](img/bg/gitlab.png)

# rspec-parameterized 2/3


<pre>
with_them do
  before do
    allow(Gitlab).to receive(:com?).and_return(<mark>dot_com</mark>)
    stub_env('GITLAB_QA_USER_AGENT', <mark>qa_user_agent</mark>)
  end

  subject { described_class.request?(<mark>request_user_agent</mark>) }

  it { is_expected.to eq(<mark>result</mark>) }
end

</pre>

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/d1ad38/spec/lib/gitlab/qa_spec.rb">https://github.com/gitlabhq/gitlabhq/blob/d1ad38/spec/lib/gitlab/qa_spec.rb</a>

---

# rspec-parameterized 3/3

```ruby
describe "Hash arguments" do
  where(a: [1, 3], b: [5, 7, 9], c: [2, 4])

  with_them do
    it "sums is even" do
      expect(a + b + c).to be_even
    end
  end
end
```

<a class="link--source" href="https://github.com/tomykaira/rspec-parameterized">tomykaira/rspec-parameterized</a>


---


<!-- header: "" -->
