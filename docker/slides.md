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



# Docker для разработки

Сергей Удалов



---


- Docker
- Docker Compose
- Трудности


---

# Docker


---
<!-- header: Docker для разработки -->


# Легенда DTD

<center>

```plantuml


node Image

rectangle Ноутбук as laptop
rectangle Gitlab
cloud Cloud


Image --> laptop: develop
Image --> Gitlab: test
Image --> Cloud: deploy



``` 

</center>



---

# Develop

* дополнительные инструменты
* скорость запуска



---

# Test

* дополнительные инструменты
* скорость сборки

---

# Deploy

- оптимизация размера

---
<!-- header: "" -->


# Разработка в docker


---
<!-- header: Разработка в docker -->


# Docker Compose


```yaml
version: "3"

services:

  app:
    build: .
    depends_on:
      - postgres
    environment:
      - DATABASE_URL=postgres://postgres@postgres/db
    ports:
      - "3000:3000"
    volumes:
      - "./:/app"

  postgres:
    image: postgres

```

--- 

    $ docker-compose run --rm app bash

    # rails server

---

# Преимущества

* легкая настройка сервисов

---

# Недостатки

* установка зависимостей (gems, node_modules, php compose, ...)
* низкая скорость
* запуск тестов

---

# Установка зависимостей

```
FROM ruby:1.9

WORKDIR /app
ADD Gemfile Gemfile.lock /app
RUN bundle install
```

---

# Notes

- docker linux host
- all in docker
- docker stop all
- docker: env, history, gems (deps)
- docker sync
- hyperkit
