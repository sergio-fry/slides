---

paginate: true
class: lead
marp: true
---
<style>
  section {
  }
  h1,body,li,p { color: black; }

  h1 {
    text-decoration: underline;
    text-decoration-color: #FF5028;
    text-underline-offset: 0.3em;
    text-decoration-thickness: 0.1em;
    padding-bottom: 0.3em;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-width: 90%;
  }
</style>
<!--
_paginate: false
_class: lead
-->


# Развитие направления Ruby

Удалов Сергей

---

# Предисловие

* супервайзинг
* RFC 
* Операционный Департамент

--- 

# Практики для улучшения

|             |                    |
|-------------|--------------------|
|  :x:        | Логирование 
|  :x:        | Тех. Документация
|  :warning:  | Мониторинг ошибок
|  :white_check_mark:  | Codereview 
|  :warning:  | CI 
|  :warning:  | Tests 
|  :x:        | Feature Toggle 
|  :warning:  | Code Quality 
|  :warning:  | Окружение разработчика

---

# Логирование

* graylog
* логируется все необходимое
* удобно искать
* совместимость с Core Module 

<!-- footer: https://confluence.infra.b-pl.pro/x/Rq5xxQ -->

---
<!-- footer: "" -->

# Техническая документация

* актуальность
* полнота

<!--
* swager
* RDoc
* State Machine
* confluence
-->

---

# Мониторинг ошибок

* sentry
* связанные задачи
* отсутствие открытых ошибок
* SLA

---

# Codereview

* цели
* SLA

<!--
footer: https://confluence.infra.b-pl.pro/x/x7FxxQ
-->
---

<!-- footer: "" -->

# CI

* tests
* lint
* security
* performance
* leaks
* monitoring
* up to date
* stable
* performance
* code quality

---

# Autotests

* reliability
* all types of tests
* coverage
* code quality
* speed
* stable
* atomicy, test structure

---

# Feature Toggle

---

# Summary


---

# Links

---

# Thanks!
