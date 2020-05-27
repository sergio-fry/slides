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



# ClickHouse. Аналитика

Сергей Удалов



---



- Бизнес-требования
- ClickHouse
- Возможности системы
- Демо



---



# Бизнес-требования

* собирать бизнес-события
* собирать системные-события
* поддерживать разные технологии
* большая пропускная способность
* аналитика



---



# ClickHouse



--- 
<!-- header: ClickHouse -->


# Основное

* быстрая вставка (throughput)
* быстрые запросы
* column-oriented
* компрессия данных
* линейная масшатибуремость
* квоты для пользователей
* стредства архивации старых данных





---



# Слабые стороны

* медленная вставка (latency)
* RAM
* JOIN
* ZooKeeper



---



# На практике

* непонятные ошибки валидации
* особенности с обработкой дат
* долгая вставка отдельных записей
* JSONExtract требователен к RAM



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

database ClickHouse  {
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


---



# Варианты использования



---

# Бонус

* CatBoost
* Обфурскация
* HTTP интеграция
* JDBC интеграция
* SQL-подобный язык запросов
* обновляемые materialized views
* materialized columns
