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
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/tasks/import_rake_spec.rb#L31


```ruby
 def expect_next_instance_of(klass, *new_args, &blk)
    stub_new(expect(klass), nil, false, *new_args, &blk)
  end
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/support/helpers/next_instance_of.rb#L4C3-L4C3


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
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/support/helpers/next_instance_of.rb#L22


```ruby

    it "tracks the event with the expected arguments and merged contexts" do
      application_experiment.track(:action, property: '_property_', context: [fake_context])

      expect_snowplow_event(
        category: 'namespaced/stub',
        action: :action,
        property: '_property_',
        context: [
          {
            schema: 'iglu:com.gitlab/fake/jsonschema/0-0-0',
            data: { data: '_data_' }
          },
          {
            schema: 'iglu:com.gitlab/gitlab_experiment/jsonschema/1-0-0',
            data: {
              experiment: 'namespaced/stub',
              key: '300b002687ba1f68591adb2f45ae67f1e56be05ad55f317cc00f1c4aa38f081a',
              variant: 'control'
            }
          }
        ]
      )
    end
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/experiments/application_experiment_spec.rb#L61



```ruby

RSpec.describe Projects::BranchesByModeService, feature_category: :source_code_management do
  let_it_be(:user) { create(:user) }
  let_it_be(:project) { create(:project, :repository) }

  let(:finder) { described_class.new(project, params) }
  let(:params) { { mode: 'all' } }
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/services/projects/branches_by_mode_service_spec.rb#L6

gem 'test-prof', '~> 1.2.3'

https://github.com/test-prof/test-prof/blob/master/docs/recipes/let_it_be.md?ysclid=lo1bo0z7cw295609270#caveats




```ruby

  subject { post_graphql(query, current_user: current_user) }

  context 'with anonymous access' do
    let_it_be(:current_user) { nil }

    before do
      subject
    end

    it_behaves_like 'a working graphql query'
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/requests/api/graphql/group/data_transfer_spec.rb#L45


