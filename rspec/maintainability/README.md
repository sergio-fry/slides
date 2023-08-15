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

![bg right](img/su.jpeg)

- PTL DAM, Ecom
- тимлид с 2017
- пишу тесты на RSpec с 2009
- разработчик с 2006
- финтех, платные дороги, SEO-инструменты, СМИ, HR

---

<!-- footer: https://bit.ly/RspecRR23 @SergeiUdalov -->

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

* низкая читаемость кода
* хрупкость
* третий пункт (?) TODO

---

# План

- читаемость
- антихрупкость
- BDD

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

# Context

---

# Describe

---

# it / specify

---

# Oneliner

<!-- меньше комментариев, читаться должен код -->

---

<!-- header: Читаемость. Ошибки -->

# Раз, два, три

```ruby
let(:user_1) { User.new(role: :admin) }
let(:user_2) { User.new(role: :manager) }
```

---

# Arrange Act Assert

---

# AAA сломан

<!-- нарушает Arrange Act Assert (TODO: как исправить) -->

```ruby
# Arrange
let(:rmq) { double(:rmq) }
let(:interactor) { Interactor.new(rmq:) }

it do
  expect(rmq).to receive(:produce) # Assert
  interactor.call # Act
end
```

---

# AAA

```ruby
# Arrange
let(:rmq) { spy(:rmq) } # <-- SPY
let(:interactor) { Interactor.new(rmq:) }

it do
  interactor.call # Act
  expect(rmq).to have_receive(:produce) # Assert
end
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

# Factory Defaults

```ruby
let(:user) { create :user }
let(:repo) { UsersRepo.new }
let(:found_user) { repo[user.id] }

it { expect(found_user.role).to eq "guest" }
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
  data: { user: { name: 'Ivan', age: 23, updated_at: Time.now.to_s } },
  meta: { ... } 
}.to_json)
```

---

# Проверяем что-то одно

```ruby
is_expected.to match(user: hash_including({ name: 'Ivan' }))
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

# Сложные stubs №1

TODO: как улучшить

```ruby
allow(Redis).to receive(:new).and_return(mock_redis)

allow(GeoMapping::ShowcaseEntityInteractor).to receive(:call)
  .and_return(OpenStruct.new(success?: true))


allow(uploader).to receive(:bucket).and_return(bucket)
allow(bucket).to receive(:object).and_return(s3_object)
```

---

<!-- _class: lead -->
<!-- header: Behavior-driven development -->
<!-- _header: "" -->

# Behavior-driven development

TODO пример запутанного кода

---

# Язык

---

# Уровень абстракции

<!-- тест должен общаться с кодом на том же уровне абстракции, использовать API кода. -->

---

# Синонимы

```ruby
RSpec.configure do |c|
  c.alias_example_group_to :detail, :detailed => true
    config.alias_it_behaves_like_to(:it_has_behavior, 'has behavior:')

end
```

---

# Встроенные matcher-ы

* be_xxx
* have_xxx
* match

---

# Свой matcher

TODO: пример + свой текст ошибки + alias

---

```ruby
feature 'Sallary report' do
  let(:user) { create :user }

  scenario 'Employer has worked during a week with fixed salary' do
    let(:day_price) { 10.0 }
    let(:period) { 7 }

    it { expect(report).to calculate_without_error }
    it { expect{ report.notify }.to send_notification_via_sms(/Salary/) }
  end
end
```


# Ошибки

---

# Тесты как чулан

<!-- тесты - это тоже код и к нему применимы все критерии качества, что и к остальному коду -->

---

# Нетестируемый код

* Даже, если тесты для кода не пишутся, проектировать код следует так, чтобы его можно было протестировать при необходимости.

---

# Тестировать то, что удобно, а не то, что важно

---

# Summary

* Кратко
* абстрагироваться от деталей
* сначала важные тесты

---

# Links

* https://github.com/sergio-fry/slides/template
* TODO matchers
* TODO checklist
