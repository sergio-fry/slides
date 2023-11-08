
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

  subject { post_graphql(query, current_user: current_user) }

  context 'with anonymous access' do
    let_it_be(:current_user) { nil }

    before do
      subject
    end

    it_behaves_like 'a working graphql query'
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/requests/api/graphql/group/data_transfer_spec.rb#L45


