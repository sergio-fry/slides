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

# Сергей Удлов

![bg right](img/su.jpeg)

- PTL DAM
- тимлид с 2017
- пишу тесты на RSpec с 2009
- разработчик с 2006
- платные дороги, SEO-инструменты, СМИ, HR


---
<!-- footer: Effective RSpec. Sergei O. Udalov -->

# Тестирование важно

* корректность
* быстрая обратная связь
* документирование
* это прикольно
* спокойствие

---

# Проблемы

* неудобно запускать
* долго ждать
* ненадежность

---

<!-- header: удобный запуск -->

# Редкий запуск

---

# CI

---

# JUnit Format

CI Example




---

# Pending

```ruby
RSpec.describe Stats do
  describe '#average' do
    it 'should be 0 when no items'
    it 'should be average of items'
  end
end
```

---

# Partial Pending

``` ruby
it 'should calculate average' do
  expect(stats).to have(3).items

  pending 'fix nil error'
  expect(stats.average).to eq 1
end
```

---


# Exact File

* `rspec spec/models/user_spec.rb`
* `rspec spec/models/user_spec.rb:42`
* `rspec spec/models`

---

# Fail Fast

---

# Suite

```bash
$ rspec
.......F...F....F..................F..F............F...F...F............F.......
...................F
```

---

# Fail Fast

```bash
$ rspec --fail-fast

........F
```

---

# Fail Fast Single file

config
```ruby
```

---

# Only Failures

```bash
$ rspec --only-failures
Run options: include {:last_run_status=>"failed"}

FFFFFFF
```

---

# Next Failure

```bash
$ rspec --next-failure
Run options: include {:last_run_status=>"failed"}
F
```

OR `rspec -n`

---

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

# Удобные сообщения об ошибке

---

<!-- header: меделленное исполнение -->

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

# Isolation

---

# Double

```ruby
 subject { CachedStats.new(cache:) }

 let(:cache) { double(:cache, get: 123) }

 it { expect(subject.count).to eq 123 }
```

---

# Double Stub

```ruby
context 'when no cache' do
  before { cache.stub(:get).and_return(nil) }
end
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

# Meta

---
# Feature Flags

```ruby
context "when caching disabled", caching: false do
end

context "when caching enabled", caching: true do
end
```


---

Так ли это?
`rspec --tag ~@caching`

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

# Backtrace

```ruby
config.filter_gems_from_backtrace 'rack', 'rack-test', 'sequel', 'sinatra' 
```

```bash
rspec --backtrace
```

---

# Ошибки

---

# Factory

```ruby
factory :user do
  email { FFaker::Internet.email }
end
```

---

# Verifying Double

```ruby
require 'lib/cache' # dependency

let(:cache) { instance_double(Cache, get: 123) }
```

---

.rspec

```
--require rails_helper
```

---

# Запуск из среды разработки

![](img/vscode_test_explorer.png)

---


# Test First

* Acceptance test
* успешная линия

<!--
мы можем не увидеть падение теста - таким образом не будем уврены, что он что-то проверяет
-->
---


# Итоги

* изучайте инструменты
* читайте тесты библиотек
* читайте книги
* настройте среду разработки

<!--

RSpec tested with Cucmeber

 -->

---

# Links

* `rspec --help`
* RSpec references
* https://rspec.info/features/3-12/rspec-core/example-groups/
* RSpec Book
* spec_helper
