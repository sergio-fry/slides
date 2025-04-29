---
marp: true
paginate: true
---

# От монолита к экосистеме контекстов DDD

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

---

## Кто я?

---

## О компании

---

## Digital Assets Management

---

## О чем поговорим?

1. Domain Driven Design
2. Монолит
3. Плагины

---

## Микросервисы

---

## Domain Driven Design

---

## Словарь

---

## Bounded Context

---

- contexts
  - certificates
    - domain
  - media_production
    - domain
  - cms
    - domain
  - video_transcoder
    - domain

---

## Хранилка файлов

---

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    meta: {
      comment: "Отличный файл"
    }
  }
}
```

---

## Сертификаты

---

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    start_date: "2025-01-01",
    end_date: "2028-12-31"
  }
}
```

--- 

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    meta: {
      comment: "Отличный файл",
      start_date: "2025-01-01",
      end_date: "2028-12-31"
    }
  }
}
```

---

```ruby
params do
  required(:directory_id).filled(:uuid)
  required(:upload_id).filled(:uuid)
  required(:name).filled(:string)
  optional(:meta).hash
end
```

