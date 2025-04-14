---
marp: true
paginate: true
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
</style>

<!-- _paginate: skip -->
# От монолита к экосистеме контекстов DDD

---

## Кто я?

---

## Не только микросервисы

---

## О проекте

---

## Результаты

- 10_000_000 файлов
- +30Гб/день
- 1.5 года в прод
- 3 месяца на MVP

---

## О чем речь?

1. DDD
2. Monolith First
3. Плагины

---

## Проблемы разработки DAM

* разные группы пользователей
* Много видов активов 
* Разные интерфейсы
* Разные валидации, механики автоматизации

---

## Архитектура Продукта

```plantuml

skinparam rectangle {
  
  backgroundColor<<DAM API>> White
}

rectangle "Ruby" as API <<DAM API>>

rectangle "nodejs" as Apollo <<Apollo Federation>>
rectangle Frontend
queue "Elixir" as ws <<Web Sockets>>
queue "Kafka" as ES <<Event Streaming>>
database PostgreSQL as db <<Database>>
database Redis as cache <<Cache>>
cloud "S3" as storage
rectangle "Ruby" as transcoder <<Video Transcoder>>
rectangle "Elixir" as events <<Event Relay>>
actor user
rectangle "Service A" as servce_a


user -> Frontend
Frontend -> ws: sub

Frontend -> Apollo
Apollo -> API 
API --> cache
API --> db

API -> storage
API --> transcoder
API --> ws: pub
events ..> db: outbox
events -> ES: pub

ES <.. servce_a: sub

```

---

## Domain Driven Design!

* Domain Model
* **Ubiquitous Language**
* **Bounded Context**

---

## Принципы

* Файлы и папки
* Разделение ядра и контекстов
* Плагины
* feature toggle

---

## Архитектура приложения

---

## Основаная часть

---

## Словарь

---

## MVP хранилка (ядро)

---

## Устройство плагина

* размещение логики
* Как технически плагины вызываются из ядра
* пример встраивания кастомных методов и полей в API
* Валидации ?
* Особенности проектирования БД и логики репозиториев в плагинах
* events, как инструмент встраивания логики
* как организованы автотесты

---

## Дальнейшее развитие

* кастомные интерфейсы
* выделение в сервисы и разделение команды

---

## Итоги

- шаги советы в аналогичных ситуациях





<!--

- шаги советы в аналогичных ситуациях
- ошибки которые совершили/ забавные исотрии
- какине преимущества получили - объективно
- https://www.youtube.com/watch?v=DsfnFrwKksA - как мерить качество кода. может быт полезно
- в начале добавить кейсы неудачного распила на микрочервисы

- как выделить агрегаты не только по плиагнам
- есть 
- словарь - не всегда оч строго, нужно уметь не путаться, если кто-то сомневается нужно добавить формулировку чтобы не было вопросов
-->
