

```ruby
require "warning"

Warning.ignore(%r{rspec/core})
Warning.ignore(%r{rspec/mocks})
Warning.ignore(/codacy/)
Warning[:experimental] = false if Warning.respond_to?(:[])
```
https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/support/warnings.rb#L5C1-L10C59

---

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
