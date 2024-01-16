# Helpers
6 из 8

---
<!-- header: Helpers 6 из 8 -->

![bg](img/bg/gitlab.png)

# `expect_next_instance_of` 1/3

```ruby
context 'when all inputs are correct' do
  it 'imports a repository' do
    # ..

    expect_next_instance_of(Project) do |project|
      expect(project).to receive(:after_import)
    end

    import_task
  end
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/tasks/import_rake_spec.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/tasks/import_rake_spec.rb</a>

---

![bg](img/bg/gitlab.png)

# `expect_next_instance_of` 2/3

```ruby
def expect_next_instance_of(klass, *new_args, &blk)
  stub_new(expect(klass), nil, false, *new_args, &blk)
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/support/helpers/next_instance_of.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/support/helpers/next_instance_of.rb</a>

---

![bg](img/bg/gitlab.png)

# `expect_next_instance_of` 3/3

```ruby
def stub_new(target, number, ordered = false, *new_args, &blk)
  receive_new = receive(:new)
  receive_new.ordered if ordered
  receive_new.with(*new_args) if new_args.present?

  if number.is_a?(Range)
    receive_new.at_least(number.begin).times if number.begin
    receive_new.at_most(number.end).times if number.end
  elsif number
    receive_new.exactly(number).times
  end

  target.to receive_new.and_wrap_original do |*original_args, **original_kwargs|
    method, *original_args = original_args
    method.call(*original_args, **original_kwargs).tap(&blk)
  end
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/support/helpers/next_instance_of.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/support/helpers/next_instance_of.rb</a>

---

![bg](img/bg/rspec.png)

# `without_env_vars` 1/2

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

![bg](img/bg/rspec.png)

# `without_env_vars` 2/2


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

---


<!-- header: "" -->
