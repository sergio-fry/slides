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

Develop.  Test. Deploy

<center>

```plantuml

rectangle Develop
rectangle Test
rectangle Deploy

Develop --> Test
Test --> Deploy

``` 

</center>



---

# Deploy

- оптимизаация размера


---

# Test

* дополнительные инструменты
* скорость сборки


---

# Develop

* дополнительные инструменты
* скорость запуска

---


# Лучше без docker

<!-- Кто использует на практике? --> 


---


# Docker Compose


```yaml
version: "3"

services:

  postgres:
    image: postgres
    ports:
      - "5432:5432"

  memcached:
    image: memcached
    ports:
      - "11211:11211"
```

```bash
$ docker-compose up -d
```



---

# Notes

- docker linux host
- all in docker
- docker stop all
- docker: env, history, gems (deps)
- docker sync
- hyperkiy
