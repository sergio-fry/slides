---
marp: true
---
<style>
  img {
    display: block;
    max-height: 100%;
    max-width: 80%;
  }
</style>


# Effective RSpec
---

# Testing Reasons

* protect
* be stupid

---
# CI
---
# Test First
---

# Rare Execution

---

# Editor

![](img/vscode_test_explorer.png)

---

# Exact File

`rspec spec/models/user_spec.rb`


---

# Exact Line

`rspec spec/models/user_spec.rb:42`

---

# --example-matches  / --pattern

---
# Fail Fast
* --fail-fast
* --only-failures
* --next-failure / -n
---

# Performance
---
# --profile
---
# aggregate_failures
---

# Double
---
# Veifiying Double
---
# Fake Object
---


# Predictable
---
# Factory

---
# Factory

```ruby
Faker in a factory
```

---
# Timecop

---
# Random Seed (--seed, --order)
---


# Tags / define / if / unless

* config.infer_spec_type_from_file_location!

--- 

# Focus

`c.filter_run_including :focus => true`

```ruby
RSpec.describe "something" do
  it "does one thing" do
  end

  it "does another thing", focus: true do
  end
end
``` 

---
# Tags feature flags

```ruby
example
```
---


# spec helpers
---
# default config (.rspec, .rspec-local)

* --format documentation
* --seed 123
- --exclude spec/integration/**
---

# Define Method

```ruby
let(:user) { create(:user) }

def create_user
  create(:user)
end

it do
  expect do
    create_user
    create_user
  end.to change{ User.count }.by(2)
end
```

---

# Other
* hooks before/after/around (also in config)
* --bisect
* pending / skip
* when_first_matching_example_defined
* subject / described_class
---

# Investigate Most Used

---

# Read Code

<!--

RSpec tested with Cucmeber

 -->
---

# Links

* RSpec references
* https://rspec.info/features/3-12/rspec-core/example-groups/
* RSpec Book
* spec_helper

---

# TODO

- убрать focus
- fail-fast example
- only failures. config example
- next failure example
- --profile example
- aggregate failures example
- double example
- verifying double typo
- verifying double example
- fake object example
- add factory slide
- factory faker example
- factory sequence example
- seed slide
- order slide
- timecop example
- timecop spec_helper after hook
- timecop after enable with tag config
- if / unless - убарть
- tag slide (key)
- meta slide (key => value)
- faeture toggle tags example
- spec_helper 
  - spec_helper
  - rails_helper
  - feature_helper
  - do not require by default
- .rspec example
  - exclude integration
- .rspec-local example
- bisect slide with example
- when_first_matching_example_defined ? что это
- RSpec book (read)
- spec_helper slides (если что-то не вошло в примеры)
