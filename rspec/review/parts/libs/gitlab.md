
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

TODO: graphql dsl
