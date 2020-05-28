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


# Назначение

* хранение фактов
* логирование
* аналилтика



---



# Возможности

* быстрая вставка (throughput)
* быстрые запросы
* column-oriented
* компрессия данных
* линейная масшатибуремость
* квоты для пользователей
* стредства архивации старых данных



---



# Особенности

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



# ClickHouse. События



--- 
<!-- header: ClickHouse. События -->




<center>

```plantuml
rectangle "Баланс-Платформа" {
  package "Проект" as Project {
    rectangle Ruby
    rectangle Python
    rectangle PHP
  }
  rectangle "Аналитика" as Analytics
  database ClickHouse
  rectangle "Отчеты" as Reports
  actor "Саппорт" as User
  actor "Аналитик" as Risk

}

cloud "РГСБ" as Bank

Ruby --> Analytics: RMQ
Python --> Analytics: RMQ
PHP --> Analytics: RMQ


Analytics --> ClickHouse: write
Reports --> Bank: bank_proxy
Reports --> ClickHouse: read
Reports --> User: HTTP
Risk --> ClickHouse: SQL

```
</center>



---



# Событие

```json
{
  "uuid": "6f265bb0-78d6-0138-3362-2cde48001122",
  "type": "sms_request",
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
