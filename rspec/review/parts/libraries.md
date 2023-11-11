

```ruby
require "warning"

Warning.ignore(%r{rspec/core})
Warning.ignore(%r{rspec/mocks})
Warning.ignore(/codacy/)
Warning[:experimental] = false if Warning.respond_to?(:[])
```
<a class="link--source" href="https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb#L5C1-L10C59">https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb#L5C1-L10C59</a>

---

```ruby

RSpec.describe Projects::BranchesByModeService, feature_category: :source_code_management do
  let_it_be(:user) { create(:user) }
  let_it_be(:project) { create(:project, :repository) }

  let(:finder) { described_class.new(project, params) }
  let(:params) { { mode: 'all' } }
```
<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/services/projects/branches_by_mode_service_spec.rb#L6">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/services/projects/branches_by_mode_service_spec.rb#L6</a>

gem 'test-prof', '~> 1.2.3'

<a class="link--source" href="https://github.com/test-prof/test-prof/blob/2c8ff6/docs/recipes/let_it_be.md#caveats">https://github.com/test-prof/test-prof/blob/2c8ff6/docs/recipes/let_it_be.md#caveats</a>

---
