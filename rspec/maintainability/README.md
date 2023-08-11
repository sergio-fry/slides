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

<!-- footer: RSpec. Поддерживаемость, Сергей Удалов, Samokat.tech -->

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

# Expect to receive

<!-- нарушает Arrange Act Assert (TODO: как исправить) -->

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
