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
<!-- header: Docker -->

# Легенда DTD

Develop.  Test. Deploy

<center>

```plantuml

node Develop
node Test
node Deploy

Develop --> Test
Test --> Deploy

``` 

</center>



---

# Deploy

* оптимизаация размера
* скорость сборки

---

# Test

* дополнительные инструменты
