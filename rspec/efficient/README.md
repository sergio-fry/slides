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


  h1, p, ul li { color: black; }
  pre { border: 0px; background: white; }

  footer { color: #bbb }
  footer a { color: #bbb }

</style>



# RSpec. Эффектиность

@SergeiUdalov, PTL DAM, Samokat.tech

---


# Сергей Удалов


![bg right](img/suzdal_gradient_square.png)

- PTL DAM, Samokat.tech
- тимлид с 2017
- пишу тесты на RSpec с 2009
- разработчик с 2006
- финтех, платные дороги, SEO-инструменты, СМИ, HR

---
<!-- footer: https://bit.ly/3M2y1xo › @SergeiUdalov › Samokat.tech  -->

# Тестирование важно

* поддерживаемость
* быстрая обратная связь
* дизайн кода
* документирование
* это прикольно

---

# RSpec. Поддерживаемость

![](img/rspec_maintainability.jpeg)

---

# Быстрая обратная связь

---

# Проблемы

* долго ждать
* неудобно запускать
* ненадежность

---

# Производительность

![bg right](img/performance.jpeg)

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



![bg right](img/launch.jpeg)

<!-- _footer: Photo by Bill Jelen -->

---


# Что именно запускать

* `rspec`
* `rspec spec/models`
* `rspec spec/models/user_spec.rb`
* `rspec spec/models/user_spec.rb:42`

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

```bash
rspec --tag @integration --tag ~@caching
```

---

# .rspec

```
--require spec_helper
--progress documentation
```

---

# .rspec-local

```bash
--exclude spec/integration/**
--tag ~@flaky
--seed 123
```

---

```bash
echo ".rspec-local" >> .gitignore
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

![](img/myronmartson.png)

![bg right](img/book_rspec3.jpeg)


---

# Ссылки

* https://youtu.be/oNIAJtWuHKg "RSpec. Поддерживаемость"
* `rspec --help`
* https://github.com/sergio-fry/spec_helper
* https://github.com/sergio-fry/nvim-config
* @SergeiUdalov
