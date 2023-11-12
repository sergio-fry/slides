---

marp: true
paginate: true
size: 4:3

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

  .link--source { color: #bbb; font-size: 0.5em; max-width: fit-content; }
</style>

<!-- _paginate: skip -->


# RSpec. Review

Сергей Удалов, PTL DAM at Samokat.tech

---

# Сергей Удалов

![bg right:35%](img/me.png)

- PTL DAM, Samokat.tech
- тимлид с 2017
- пишу тесты на RSpec с 2009
- разработчик с 2006
- финтех, платные дороги, SEO-инструменты, СМИ, HR

---

<!-- _footer: "" -->
<!-- _class: invert -->

![bg](img/rubyrussia_2023.jpeg)

---

<!-- footer: bit.ly/3SBDkYI › @SergeiUdalov › Samokat.tech  -->

TODO: Зачем это доклад?

---

# Рассмотрим

dry-rb gitlab hanami pg rom-rb
rspec ruby-concurrency vcr

---

# План

1. Конфигурация
2. Контекст
3. Тестовые классы
4. Expectation
6. Faker
7. Helpers
8. Выразительность
5. Acceptance
9. Библиотеки

---

!!!include(parts/config.md)!!!
!!!include(parts/context.md)!!!
!!!include(parts/context_classes.md)!!!
!!!include(parts/expectation.md)!!!
!!!include(parts/faker.md)!!!
!!!include(parts/helpers.md)!!!
!!!include(parts/semantic.md)!!!
!!!include(parts/acceptance.md)!!!
!!!include(parts/libraries.md)!!!


# Итоги

1) тестируй
2) тестируй важное
3) читай чужой код

---
<style scoped>
li { font-size: 0.9em }
</style>

# Links

1. https://youtu.be/oNIAJtWuHKg "RSpec. Поддерживаемость"
1. https://bit.ly/3QSGIxh Другие выступления

---

# Спасибо!
