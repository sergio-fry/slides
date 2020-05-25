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

# Clickhouse Events

Сергей Удалов

---

# Цели

* контроль нарастания сложности
* независимая разработка
* возмоножсть выделить микросервис

---

# Принципы

* чистая архитектура
* сначала монолит
* кричащая архитектура

---

# Схема

<center>

```plantuml

database Clickhouse
cloud bank

```

</center>
