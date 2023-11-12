# Библиотеки

---
<!-- header: Библиотеки  -->

```ruby
require "warning"

Warning.ignore(%r{rspec/core})
Warning.ignore(%r{rspec/mocks})
Warning.ignore(/codacy/)
Warning[:experimental] = false if Warning.respond_to?(:[])
```

<a class="link--source" href="https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb">https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb</a>

---

# TestProf 1/2

```ruby
RSpec.describe Projects::BranchesByModeService, feature_category: :source_code_management do
  let_it_be(:user) { create(:user) }
  let_it_be(:project) { create(:project, :repository) }

  let(:finder) { described_class.new(project, params) }
  let(:params) { { mode: 'all' } }
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/services/projects/branches_by_mode_service_spec.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/services/projects/branches_by_mode_service_spec.rb</a>

---

# TestProf 2/2

gem 'test-prof', '~> 1.2.3'

<a class="link--source" href="https://github.com/test-prof/test-prof/blob/2c8ff6/docs/recipes/let_it_be.md#caveats">https://github.com/test-prof/test-prof/blob/2c8ff6/docs/recipes/let_it_be.md#caveats</a>

---

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

# rspec-parameterized 2/3


```ruby
with_them do
  before do
    allow(Gitlab).to receive(:com?).and_return(dot_com)
    stub_env('GITLAB_QA_USER_AGENT', qa_user_agent)
  end

  subject { described_class.request?(request_user_agent) }

  it { is_expected.to eq(result) }
end

```

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

https://www.rubydoc.info/gems/undercover/

---

<!-- header: "" -->
