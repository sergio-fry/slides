---
paginate: true
---
<style>
  section {
    background: white;
  }
</style>

<!--
_paginate: false
_class: lead
-->


# КН. Документация

Серей Удалов

---

<!-- footer: КН. Документация. Сергей Удалов -->


# О чем пойдет речь

- Что программируем
- История документации
- Где мы сейчас
- Планы

---

<!-- header: Что программируем -->

# Общие сервисы

- Мегафон
- Вопросник


---

# API

- обновление / создание заявки
- список / поиск по заявкам
- просмотр заявки
- несколько интеграций

---

# Стратегии

```ruby
class SuitableAgeChecker < Strategy
  def call(payload)
    apply_strategy(has_age_suitable: payload[:age] > 18)
  end
end
```

---

<!-- header: История документации -->

# Documentation Driven

<img src="img/RGSCASH-804.png" alt="drawing" width="80%"/>

---

# Детальное описание

<img src="img/RGSCASH-4886.png" alt="drawing" width="80%"/>

---

<!-- header: Где мы сейчас -->

# Статус

|                     | Статус   |
|---------------------|----------|
| API                 | ОК       |
| Readme              | ОК       |
| Инфраструктура      | Missing  |
| Статусная модель    | **FAIL** |


---

<!-- header: "" -->

# Планы 

* Генерация документации
* Инструменты анализа
* Краткое описание, а не полное, но актуальное

---

# Спасибо

