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
<!-- header: Effective RSpec. Sergei O. Udalov -->

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

---

<!-- _header: Fail Fast -->

# Suite

```bash
$ rspec
.......F...F....F..................F..F............F...F...F............F.......
...................F
```

---

<!-- _header: Fail Fast -->

# Fail Fast

```bash
$ rspec --fail-fast

........F
```


---

<!-- _header: Fail Fast -->

# Only Failures

```bash
$ rspec --only-failures
Run options: include {:last_run_status=>"failed"}

FFFFFFF
```

---

<!-- _header: Fail Fast -->

# Next Failure

```bash
$ rspec --next-failure
Run options: include {:last_run_status=>"failed"}
F
```

OR `rspec -n`

---

<!-- _header: Fail Fast -->

# Config

spec_helper.rb
```ruby
config.example_status_persistence_file_path = "spec/examples.txt"
```

.gitignore
```
/spec/examples.txt
```


---

# Performance
---
# Profile

```bash
$ rspec --profile 5
Run options: exclude {:failing=>true}

Randomized with seed 18281
..............

Top 5 slowest examples (4.02 seconds, 57.4% of total time):
  Profile
    0.85078 seconds ./spec/profile_spec.rb:6
  Profile
    0.81927 seconds ./spec/profile_spec.rb:7
  Profile
    0.81688 seconds ./spec/profile_spec.rb:8
  Profile
    0.81053 seconds ./spec/profile_spec.rb:11
  Profile
    0.72669 seconds ./spec/profile_spec.rb:9

Top 2 slowest example groups:
  Profile
    0.53897 seconds average (7.01 seconds / 13 examples) ./spec/profile_spec.rb:1
  doubl example
    0.00046 seconds average (0.00046 seconds / 1 example) ./spec/double_spec.rb:1

Finished in 7.01 seconds (files took 0.05331 seconds to load)
14 examples, 0 failures

Randomized with seed 18281
```

---

# Aggregate Failures

```ruby
describe 'Response' do
  let(:response) { Internet.new.get('http://example.com/test') }

  it { expect(response['x-time'].to_f).to be < 0.1 }
  it { expect(response.status).to eq 200 }
end
```

---

<!-- _header: Aggregate Failures -->

# `:aggregate_failures` tag

```ruby
describe 'Response', :aggregate_failures do
  let(:response) { Internet.new.get('http://example.com/test') }

  it {
    expect(response['x-time'].to_f).to be < 0.1
    expect(response.status).to eq 200
  }
end
```

---

<!-- _header: Aggregate Failures -->

# `aggregate_failures` bloack

```ruby
describe 'Response' do
  let(:response) { Internet.new.get('http://example.com/test') }

  it {
    expect(response.status).to eq 200

    aggregate_failures do
      expect(response['x-time'].to_f).to be < 0.1
      expect(response['content-type']).to eq 'application/json'
    end
  }
end
```

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
- RSpec rubocop
