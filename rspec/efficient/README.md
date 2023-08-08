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


# Эффективное использование RSpec

Сергей Удалов, PTL DAM Samokat.tech

---

# Сергей Удалов

![bg right](img/su.jpeg)

- PTL DAM, Ecom
- тимлид с 2017
- пишу тесты на RSpec с 2009
- разработчик с 2006
- финтех, платные дороги, SEO-инструменты, СМИ, HR

---
<!-- footer: Эффективное использование RSpec, Сергей Удалов, Samokat.tech -->

# Тестирование важно

* поддерживаемость
* быстрая обратная связь
* дизайн кода
* документирование
* это прикольно

---

# Быстрая обратная связь

<!-- главным образом будем говорить об этом -->

---

# Проблемы

* долго ждать
* неудобно запускать
* ненадежность

---

# План

1. Производительность
2. Запуск тестов
3. Надежность
4. Ошибки

---

# Производительность

![bg right](img/performance.jpeg)

<!-- header: Производительность -->

<!-- _footer: Photo by Marc Sendra Martorell -->

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

# Spring

```ruby
group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end
```

```bash
$ bundle exec spring rspec
Running via Spring preloader in process 90905
...............................................................

Finished in 0.01258 seconds (files took 0.11336 seconds to load)
63 examples, 0 failures
```

---

# Изоляция

![](img/clean_architectur.jpeg)

---

# Spec Helpers

```ruby
require 'spec_helper'
```
vs 
```ruby
require 'rails_helper'
```

---

# Double

```ruby
 subject { CachedStats.new(cache:) }

 let(:cache) { double(:cache, get: 123) }

 it { expect(subject.count).to eq 123 }
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



![bg right](img/launch.jpeg)

<!-- _footer: Photo by Bill Jelen -->

---


# Что именно запускать

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

# Tags

```ruby
# rspec --tag @caching
context "when caching enabled", caching: true do
  # ...
end

# rspec --tag ~@caching
context "when caching disabled", caching: false do
  # ...
end
```

---

# .rspec-local

```bash
--exclude spec/integration/**
--seed 123
```

---

<style scoped>
  img {
    display: block;
    max-width: 70%;
  }
</style>

# Запуск из среды разработки

![](img/vscode_test_explorer.png)

---

# Надежность

![bg right](img/hammer.jpeg)

<!-- header: Надежность -->

<!-- _footer: Photo by iMattSmart -->

---


# Timecop

```ruby
before { Timecop.travel '2023-01-01 12:00' }
after { Timecop.return }
```

---

# Random Seed

```ruby
Kernel.srand config.seed
```

```bash
$ rspec --seed 18281

Randomized with seed 18281
.FFFF...............

```


---

# Ошибки

<!-- header: Ошибки -->

![bg right](img/broken.jpeg)

<!-- _footer: Photo by Marianna Smiley -->

---

# Не настроен CI

<!--
* источник правды
* Merge request
* полнота обратной связи
-->

---

# JUnit Format

`rspec --format RspecJunitFormatter --out rspec.xml`

![](img/junit_test_report.png)

---

# Всегда полное окружение

```bash
--require rails_helper
```

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

* ручной дебаг
* отравление техническими деталями
* тратим мыслетопливо на рутину

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

# Ссылки

* "Effective Testing with RSpec 3", Myron Marston and Ian Dees
* `rspec --help`
* https://rspec.info/features/3-12/rspec-core/example-groups/
* https://github.com/sergio-fry/spec_helper
* https://github.com/sergio-fry/slides rspec/efficient

---

# Контакты

- https://sergei.udalovs.ru
- udalov.x@mail.ru
- tg @SergeiUdalov
- linkedin @sergeiudalov
