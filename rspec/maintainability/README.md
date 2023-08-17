---

marp: true
paginate: true
size: 16:9

---

<style>
img {
display: block;
max-height: 100%;
max-width: 80%;

}
pre {
background: white ;
border: 0px;
}
</style>

# Rspec. Поддерживаемость

---

# Сергей Удалов

TODO другое фото

![bg right](img/su.jpeg)

- PTL DAM, Ecom
- тимлид с 2017
- пишу тесты на RSpec с 2009
- разработчик с 2006
- финтех, платные дороги, SEO-инструменты, СМИ, HR

---

<!-- footer: https://bit.ly/RR23RSpec @SergeiUdalov Ecom -->

# Тестирование важно

* поддерживаемость
* быстрая обратная связь
* дизайн кода
* документирование
* это прикольно

---

# Поддерживаемость кода тестов

---

# Проблемы

* низкая читаемость
* хрупкость
* низкая выразительность

---

# План

- читаемость
- антихрупкость
- DSL

---

<!-- _class: lead -->
<!-- header: Читаемость -->
<!-- _header: "" -->

# Читаемость

---

# Краткость


---

# Контекст

<!-- описан в самом тесте, поэтому не fixtures, а faker -->

---

```ruby
include_context "with authenticated user"
include_context "when cache is unavailable"
```

---

# Context

---

```ruby
context "when user is manager" do
  let(:user) { build :user, :manager }

  context "and no entries" do
    before { entries.clear }

    # ...
  end
end
```

---

# Describe

---

```ruby
describe "Salary Report" do
  subject(:report) { SalaryReport.new }

  describe "summary" do
    subject { report.summary }

    # ...
  end
end
```

---

# Oneliner

<!-- меньше комментариев, читаться должен код -->

---

```ruby
it { is_expected.to be_valid }
it { expect(report.salary).to eq 0 }
```

---

<!-- header: Читаемость. Ошибки -->

# Раз, два, три

```ruby
let(:user_1) { User.new(role: :admin) }
let(:user_2) { User.new(role: :manager) }
```

---

# Раз, два, три

```ruby
let(:admin) { User.new(role: :admin) }
let(:manager) { User.new(role: :manager) }
```

---

# Arrange Act Assert

* подготовка
* выполнение
* проверка

---

# Arrange Act Assert. Нарушение


```ruby
rmq = double(:rmq)                # Arrange
interactor = Interactor.new(rmq:) # Arrange

expect(rmq).to receive(:produce)  # Assert

interactor.call                   # Act
```

---

# Arrange Act Assert. Исправлено

```ruby
rmq = spy(:rmq)                       # Arrange
interactor = Interactor.new(rmq:)     # Arrange

interactor.call                       # Act

expect(rmq).to have_receive(:produce) # Assert
```

---

# Subject как действие

```ruby
subject { post :create, params: { id: 1, title: "New title" } }

it do
  subject
  expect(response).to be_success
end
```

---

```ruby
def run_request = post :create, params: { id: 1, title: "New title" }

it do
  run_request
  expect(response).to be_success
end
```

<!-- тут удобнее повторный вызов -->

---

# Скрытый контекст

```ruby
subject { create :user }
it_behaves_like "A user of age", 42
```

---

```ruby
subject { create :user, age: 42 }
it_behaves_like "A user of age", 42
```

---

# Ожидаемое ожидание

```ruby
it { expect(result).to eq expected }
```

---

# expected_result

```ruby
it { expect(response).to include(status: "ok") }
it { expect(response).to include(id: user.id) }
```

---

<!-- _class: lead -->
<!-- header: Антихрупкость -->
<!-- _header: "" -->

# Антихрупкость

---

# Высокое зацепление (Coupling)

---

# Тестировать поведение

TODO пример

<!--
* а не техническую реализацию
* если хочется протестировать реализцию, то нужно вынести это в класс
-->


---
<!-- header: Антихрупкость. Ошибки -->


# Требовать лишнего

```ruby
is_expected.to eq({
  data: { user: { name: "Ivan", age: 23, updated_at: Time.now.to_s } },
  meta: { ... } 
}.to_json)
```

---

# Проверяем необходимое

```ruby
is_expected.to match(user: hash_including({ name: "Ivan" }))
```

---

# Проверяем структуру

```ruby
it do
  is_expected.to match(
    hash_including(
      time: kind_of(Time),
      user_ids: array_including(user_id),
      meta: hash_including(x_time: anything)
    )
  )
end
```

---

# Многократное тестирование

---

# Сложные stubs

```ruby
allow(Redis).to receive(:new).and_return(FakeRedis.new)

allow(GeoMapping::ShowcaseEntityInteractor).to receive(:call)
  .and_return(OpenStruct.new(success?: true))

allow(uploader).to receive(:bucket).and_return(bucket)
allow(bucket).to receive(:object).and_return(s3_object)
```

---

```ruby
class FakeStorage
  def object(key)
    uploader.bucket.s3_object(key)
  end
end

let(:storage) { FakeStorage.new }
let(:interactor) { Interactor.new(storage:) }
```

---

<!-- _class: lead -->
<!-- header: Domain Specific Language (DSL) -->
<!-- _header: "" -->

# Domain Specific Language (DSL)

TODO пример запутанного кода

- валиадция запроса ?
- отчет ?
- работа со страницей  ?
- graphql ?


---

# Язык важен

<!-- тест должен общаться с кодом на том же уровне абстракции, использовать API кода. -->

---

# Синонимы

```ruby
RSpec.configure do |c|
  c.alias_example_group_to :scenario, integration: true
  c.alias_example_to :he  # he { is_expected.to have_job }
end
```

---

# Встроенные matcher-ы

TODO сикро примеры в одну строку

* be_xxx `expect(response).to be_success`
* have_xxx
* match

https://bit.ly/RR23RSpecMatchers

---

# Свой matcher

TODO: matcher alias
TODO: пример + свой текст ошибки + alias

---

TODO выбрать, развить

```ruby
describe Human do
  include_context "when he is a man"
  include_context "when he is married"

  he { is_expected.to have_a_house }
  he { is_expected.to have_a_job }
end
```

---

```ruby
feature "Sallary report" do
  let(:user) { create :user }

  scenario "Employer has worked during a week with fixed salary" do
    let(:day_price) { 10.0 }
    let(:period) { 7 }

    it { expect(report).to calculate_successfully }
    it { expect{ report.notify }.to send_notification_via_sms(/Salary/) }
    it { expect(report).to report_with_ } # TODO
  end
end
```

---
<!-- header: "" -->

# Ошибки

TODO списком на одном слайде, так как нет текста

---

# Тесты как чулан

<!-- тесты - это тоже код и к нему применимы все критерии качества, что и к остальному коду -->

---

# Нетестируемый код

<!-- Даже, если тесты для кода не пишутся, проектировать код следует так, чтобы его можно было протестировать при необходимости. -->

---

# Тестировать то, что удобно, а не то, что важно

---

# Checklist

TODO уменьшить шрифт, чтобы влезло

* тесты можно прочитать
* нет скрытого контекста
* глаголы для действий
* свои matchers
* названия отражают роль
* allow to receive chaining
* соблюдается AAA
* проверяете только необходимое
* тестируется поведение, а не реализация

https://bit.ly/RR23RSpecCheck

---

# Links

* Matchers https://bit.ly/RR23RSpecMatchers
* "Effective Testing with RSpec 3", Myron Marston and Ian Dees
* слайды https://bit.ly/RR23RSpec
* checklist https://bit.ly/RR23RSpecCheck
* @SergeiUdalov

---

# Спасибо!
