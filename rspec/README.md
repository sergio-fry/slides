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
- финтех, платные дороги, SEO-инструменты, СМИ, HR

---
<!-- footer: Effective RSpec. Sergei O. Udalov -->

# Тестирование важно

* поддерживаемость
* спокойствие
* быстрая обратная связь
* дизайн кода
* документирование
* это прикольно

---

# Быстрая обратная связь

<!-- главным образом будем говорить об этом -->

---

# Проблемы

* неудобно запускать
* долго ждать
* ненадежность


---

# Производительность

<!-- header: Производительность -->

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

# Запуск тестов

<!-- header: Запуск тестов -->

---


# Exact File

* `rspec spec/models/user_spec.rb`
* `rspec spec/models/user_spec.rb:42`
* `rspec spec/models`

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

# .rspec

```
--require spec_helper
```

---

# .rspec-local

```bash
--exclude spec/integration/**
--seed 123
```

---

# Pending

```ruby
let(:collection) { Collection.new([1, 2, 3]) }

describe '#average' do
  it 'should be 0 when no items'

  it 'should be average of items', pending: true do
    expect(stats.average).to eq 2
  end
end
```

---

# Partial Pending

TODO запускается ли строчка ниже?
``` ruby
it 'should calculate average' do
  expect(stats).to have(3).items

  pending 'fix nil error'
  expect(stats.average).to eq 1
end
```

---

# Запуск из среды разработки

![](img/vscode_test_explorer.png)


---

# Удобные сообщения об ошибке

TODO


---

# JUnit Format

CI Example

---

# Coderay

```ruby
gem 'coderay'
```

TODO

---

# Надежность

TODO

<!-- header: Надежность -->

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

```ruby
context "when caching disabled", caching: false do
  # ...
end

context "when caching enabled", caching: true do
  # ...
end
```


TODO check

```bash
rspec --tag ~@caching
```

---

# Spec Helpers

```ruby
require 'spec_helper'
```

---

# Ошибки

<!-- header: Ошибки -->

---

# Не настроен CI

<!--
* источник правды
* Merge request
* полнота обратной связи
-->

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


# Тест после кода

* Acceptance test
* успешная линия

<!--
мы можем не увидеть падение теста - таким образом не будем уврены, что он что-то проверяет
-->

---

# Редкий запуск

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

TODO

* `rspec --help`
* RSpec references
* https://rspec.info/features/3-12/rspec-core/example-groups/
* RSpec Book
* spec_helper
