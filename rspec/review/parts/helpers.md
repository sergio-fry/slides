
```ruby
context 'when all inputs are correct' do
  it 'imports a repository' do
    expect_next_instance_of(Gitlab::GithubImport::SequentialImporter) do |importer|
      expect(importer).to receive(:execute)
    end

    expect_next_instance_of(Project) do |project|
      expect(project).to receive(:after_import)
    end

    import_task
  end
end
```
<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/tasks/import_rake_spec.rb#L31">https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/tasks/import_rake_spec.rb#L31</a>

---

```ruby
 def expect_next_instance_of(klass, *new_args, &blk)
    stub_new(expect(klass), nil, false, *new_args, &blk)
  end
```
<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/support/helpers/next_instance_of.rb#L4C3-L4C3">https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/support/helpers/next_instance_of.rb#L4C3-L4C3</a>

---

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
<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/support/helpers/next_instance_of.rb#L22">https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/support/helpers/next_instance_of.rb#L22</a>

---
