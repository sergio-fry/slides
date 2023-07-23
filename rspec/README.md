---
marp: true
paginate: true
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

# Обо мне

* PTL DAM
* разработчик с 2006
* тимлид с 2017
* платные дороги, SEO-инструменты, СМИ

---
<!-- footer: Effective RSpec. Sergei O. Udalov -->

# Testing Matters

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
```

---

# Single Expectation

---

# Aggregate Failures

```ruby
let(:response) { Internet.new.get('http://example.com/test') }

it { expect(response['x-time'].to_f).to be < 0.1 }
it { expect(response.status).to eq 200 }
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
let(:response) { Internet.new.get('http://example.com/test') }

it {
  expect(response.status).to eq 200

  aggregate_failures do
    expect(response['x-time'].to_f).to be < 0.1
    expect(response['content-type']).to eq 'application/json'
  end
}
```

---

# Double

---

# Double

```ruby
 subject { CachedStats.new(cache:) }

 let(:cache) { double(:cache, get: 123) }

 it { expect(subject.count).to eq 123 }
```

---

# Verifying Double

---

# Verifying Double

```ruby
require 'lib/cache' # dependency

let(:cache) { instance_double(Cache, get: 123) }
```

---

# Fake Object

---

# Fake Object

```ruby
module Testing
  class FakeCache
    def initialize
      @data = {}
    end
  
    def get(key) = @data[key]
    def put(key, value) = @data[key] = value
  end
end
```

---

# Factory

---

# Factory

```ruby
factory :user do
  email { FFaker::Internet.email }
end
```

---

# Factory Sequence

```ruby
factory :user do
  sequence(:email) { |n| "user#{n}@example.com" }
end
```

---

# Predictable

---

# Timecop

```ruby
before { Timecop.travel '2023-01-01 12:00' }
after { Timecop.return }
```

---

```bash
$ rspec

Randomized with seed 18281
.FFFF...............
```

---

# Random Seed

```bash
$ rspec --seed 18281

Randomized with seed 18281
.FFFF...............

```

---

# Random Seed Config

```ruby
Kernel.srand config.seed
```

---

# Tags

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
