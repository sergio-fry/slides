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


# RSpec. Codereview

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

<!-- footer: <a href="https://bit.ly/RSpec23">bit.ly/RSpec23</a> › @SergeiUdalov › Samokat.tech  -->

# Codereview

---

<style scoped>
  img { width: 7em; }
  table, th, td, tr { border: 0px !important; background: white }
</style>

|                          |                          |                                    |                       |
| ------------------------ | ------------------------ | ---------------------------------- | --------------------- |
| ![](img/logo/dry-rb.png) | ![](img/logo/gitlab.png) | ![](img/logo/hanami.png)           | ![](img/logo/pg.png)  |
| ![](img/logo/rom-rb.png) | ![](img/logo/rspec.png)  | ![](img/logo/ruby-concurrency.png) | ![](img/logo/vcr.png) |


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

---

!!!include(parts/config.md)!!!
!!!include(parts/context.md)!!!
!!!include(parts/context_classes.md)!!!
!!!include(parts/expectation.md)!!!
!!!include(parts/faker.md)!!!
!!!include(parts/helpers.md)!!!
!!!include(parts/semantic.md)!!!
!!!include(parts/acceptance.md)!!!


# Итоги

1. тестируй
2. тестируй важное
3. читай чужой код

---

<center>

![width:10em](img/iceberg.png)

</center>

---
<style scoped>
li { font-size: 0.9em }
</style>




# Сылки

1. https://bit.ly/3QSGIxh "RSpec. Поддерживаемость"
2. https://github.com/jeremyevans/ruby-warning
3. https://github.com/test-prof/test-prof
4. https://github.com/rspec-parameterized/rspec-parameterized-core

---

# Спасибо!
