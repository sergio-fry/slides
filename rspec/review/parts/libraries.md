# Библиотеки
9 из 9

---
<!-- header: Библиотеки 9 из 9  -->

![bg](img/bg/dry-rb.png)

```ruby
require "warning"

Warning.ignore(%r{rspec/core})
Warning.ignore(%r{rspec/mocks})
Warning.ignore(/codacy/)
Warning[:experimental] = false if Warning.respond_to?(:[])
```

<a class="link--source" href="https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb">https://github.com/dry-rb/dry-monads/blob/704c1b/spec/support/warnings.rb</a>

---
![bg](img/bg/gitlab.png)

# let_it_be

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

# TestProf

![](img/test-prof.png)

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
