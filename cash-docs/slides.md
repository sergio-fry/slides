---
paginate: true
theme: gaia
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
