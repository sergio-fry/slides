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

<!-- footer: Развитие направления Ruby -->

# Предисловие

* тимлид
* супервайзинг
* RFC 
* Операционный Департамент

--- 

# Практики для улучшения

|                     |                   |             |                       |
|---------------------|-------------------|-------------|-----------------------|
|  :x:                | Логирование       |  :warning:  | Tests 
|  :x:                | Тех. Документация |  :x:        | Feature Toggle 
|  :warning:          | Мониторинг ошибок |  :warning:  | Code Quality 
|  :white_check_mark: | Codereview        |  :warning:  | Окружение разработчика
|  :warning:          | CI 





---

# Логирование


---

<!-- header: Лоигирование -->

# Зачем?

* безопасность
* удобство
  * разработчик
  * саппорт
  * QA

---

# Что?

* graylog
* события
* поиск
* безопасность
* модуль "Логирование"

<!-- footer: https://confluence.infra.b-pl.pro/x/Rq5xxQ -->

---


# События

* запросы и ответы
* ошибки
* статусы
* обновления
* бизнес-события

---

# Meta

* Request ID
* User ID
* X Request ID
* Level
* Trace

---

# Модуль "Логирование"

```plantuml
package "A" {
	[IRS] --> (STDOUT): X
	[BPM] --> (STDOUT): X

	(STDOUT) --> [Graylog]
}

package "B" {
        [IRS] as irs2
	[BPM] as bpm2

	irs2 --> (Adapter): X
	bpm2 --> (Adapter): X

	(Adapter) --> [Logger Module]
}

```

---
<!-- header: "" -->
<!-- footer: Развитие направления Ruby -->

# Техническая документация

* полнота
  * API
  * статусные переходы
  * что-то еще
* актуальность
    * автогенерация
    * confluence

---

# Мониторинг ошибок

* sentry
* связанные задачи
* отсутствие открытых ошибок
* SLA

---

# Codereview

* вовлечение
* качество
* обмен опытом
* SLA

<!--
footer: https://confluence.infra.b-pl.pro/x/x7FxxQ ADR-7
-->

---

<!-- footer: Развитие направления Ruby -->

# CI

* проверки
  * tests
  * lint
  * security
  * performance
  * leaks
  * code quality
* стабильность
* скорость работы

---

# Autotests

* покрытие
* доверие
* качество кода
* атомарность
* Arrange, Act, Assert (AAA)
* стабильность
* скорость работы

---

# Feature Toggle

---

# Планы

* логирование
* документирование
* CI
* автотесты

---

# Послесловие

* мониторинг качества применения
* база знаний

---

# Cсылки

1. https://confluence.infra.b-pl.pro/x/aaFxxQ - База знаний
1. https://confluence.infra.b-pl.pro/x/NJVxxQ - Лучшие практики
1. https://confluence.infra.b-pl.pro/x/Rq5xxQ - Логирование
1. https://confluence.infra.b-pl.pro/x/x7FxxQ - Codereview ADR-7

---

# Спасибо!
