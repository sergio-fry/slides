---
paginate: true
theme: gaia
---
<style>
  section {
    background: white;
  }
  td {
    background: white !important;
    border: 0px !important;
  }
  .folders {
    font-size: 18px;
  }
</style>

<!--
_paginate: false
class: lead
-->

# Clickhouse События

Сергей Удалов

---

# Назначение

Сервис нужен, чтобы регистрировать события из разных источников для использования в отчетах, аналитических исследованиях и для принятия решений.

---

# Требования

* Большая пропускная способность
* Обработка сложных запросов
* Добавление своих типов событий

--- 
# Событие

```json
{
  "uuid": "6f265bb0-78d6-0138-3362-2cde48001122",
  "type": "sms",
  "dt": "2020-05-15T15:35:07+03:00",
  "data": {
    "phone": "79161234567",
    "request_id": 11243,
    "text": "Кредит одобрен",
    "cost": 100
  },
  "meta": {
    "app": "bpm",
    "app_version": "v14.0.1"
  }
}
```


---

# Схема

<center>

```plantuml

database Clickhouse  {
  database "Project" as db.project
  database "Analytics" as db.analytics

  db.analytics --> db.project: update views
}

```
</center>

---

# Пример запроса 1

```sql
SELECT COUNT(1) FROM forms;
```
