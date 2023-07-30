---
paginate: true
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
- ClickHouse. Аналитика
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
* аналитика



---



# Возможности

* быстрая вставка (throughput)
* быстрые запросы
* column-oriented
* компрессия данных
* линейная масшатибуремость
* квоты для пользователей



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
* требователен к RAM



---



# ClickHouse. Аналитика



--- 
<!-- header: ClickHouse. Аналитика -->

<center>

```plantuml
!!!include(_scheme.md)!!!

hide bank
hide Reports
hide Risk
hide Support
hide Python
hide PHP
```
</center>

---

<center>

```plantuml
!!!include(_scheme.md)!!!

hide bank
hide Reports
hide Risk
hide Support
```
</center>

---

<center>

```plantuml
!!!include(_scheme.md)!!!

hide bank
hide Reports
hide Support
```
</center>

---

<center>

```plantuml
!!!include(_scheme.md)!!!

hide bank
```
</center>


---

<center>

```plantuml
!!!include(_scheme.md)!!!
```
</center>

---

# Тип

```json
curl --request POST \
  --url http://analytics.balance-pl.ru/api/event_types \
  --header 'content-type: application/json' \
  --data 
{
	"name": "sms_request",
	"fields": [{
		"name": "phone",
		"type": "String"
	}, {
		"name": "request_id",
		"type": "UInt64"
	}, {
		"name": "text",
		"type": "String"
	}, {
		"name": "cost",
		"type": "UInt32"
	}]
}
```

---



# Событие

```json
curl --request POST \
  --url http://analytics.balance-pl.ru/api/events \
  --header 'content-type: application/json' \
  --data 
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
    "app_version": "v14.0.1",
    "source": "Operator",
    "source_id": "42"
  }
}
```



---



# Успех

```json
{
	"status": "ok"
}
```



---



# Ошибка


```bash
Got status 500 (expected 200): Code: 27, e.displayText() = DB::Exception:
Cannot parse input: expected , before: .0,600000.0,200000.0,700000.0,0,0,0,1,0.
79,"{""id"":1573157,""action"":""done"",""params"":{""id"":1573157,""SCORE"":
{""value"":""0.79"",""status"":""SUCCESS""}: (at row 1) Row 1: Column 0, name:
income_confirmation_page_done, type: UInt8, parsed text: "0" Column 1, name:
passport_issuer_page_verification_status, type: String, parsed text:
"system_error" Column 2, name: passport_issuer_page_verification_message,
```


---



# Ошибка

```json
{
	"status": "error",
	"errors": [
		["cost", ["must be an integer"]]
	]
}
```



---



# RMQ

vhost: **srv-st**
exchange: **services**
routing key: **analytics.events**



---


# Возможности

* добавить свой тип
* RMQ RPC
* логирование
* мониторинг
* Int, Float, String, UUID
* DateTime, Boolean



---



# Планируется

* увеличение производительности
* namespaces: видимость
* namespaces: квоты
* загрузка пачками (?)



---


<!-- header: "Архиация" -->


# Архивация

<center>

```plantuml

rectangle BPM
rectangle "Аналитика" as Analytics
database ClickHouse
actor "Аналитик" as Risk

BPM --> Analytics
note on link: Ночная выгрузка \nстарых данных

Analytics --> ClickHouse: write
Risk --> ClickHouse: SQL

```

</center>



---

# Сжатие


```sql
SELECT
    name,
    type,
    formatReadableSize(data_compressed_bytes) AS compressed,
    formatReadableSize(data_uncompressed_bytes) AS uncompressed,
    data_uncompressed_bytes / data_compressed_bytes AS ratio
FROM system.columns
WHERE (database = 'potreb_rgsb_production') and (table = 'responses')
ORDER BY data_compressed_bytes DESC
LIMIT 10
```

---


# Сжатие

|name|type|compressed|uncompressed|ratio|
|----|----|----------|------------|-----|
|raw_message|String|21.26 GiB|177.33 GiB|8.342042|
|worker_id|UInt64|39.60 MiB|91.88 MiB|2.3203497|
|name|String|29.14 MiB|455.84 MiB|15.640787|
|received_at|DateTime|27.94 MiB|45.94 MiB|1.6443692|
|form_id|UInt64|14.99 MiB|91.88 MiB|6.127827|
|status|String|6.27 MiB|122.20 MiB|19.491976|
|app_version|String|2.53 MiB|470.87 MiB|186.41441|



---



# TTL 

```

CREATE TABLE example_table
(
    d DateTime,
    a Int
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(d)
ORDER BY d
TTL d + INTERVAL 1 MONTH [DELETE],
    d + INTERVAL 1 WEEK TO VOLUME 'aaa',
    d + INTERVAL 2 WEEK TO DISK 'bbb';
```




---
<!-- header: "" -->



# Бонус

* CatBoost
* Обфурскация
* HTTP интеграция
* JDBC интеграция
* SQL-подобный язык запросов
* обновляемые materialized views
* materialized columns



---



# Open Source


https://gitlab.infra.b-pl.pro/lib/clickhouse-analytics



---



# Спасибо!
