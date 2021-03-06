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

# Модульное ruby-приложение

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

# Чистая архитектура

![height:15em](img/clean_architecture.jpeg)


---

# Fullstack-модуль

<center>

```plantuml
digraph G {
  node [shape="box" style="filled" width="2"]

  subgraph cluster3 {
    entities [label="Entites" fillcolor="#FEFBBA" width="2"];
  }

  subgraph cluster1 {
    label = "Orders";

    use_cases [label="Use Cases" fillcolor="#FFA09B"]
    interface_adapters [label="Interface Adapters" fillcolor="#A2FDBA"]
    framework_drivers [label="Frameworks & Drivers" fillcolor="#A4D8FF"]

    framework_drivers -> interface_adapters;
		interface_adapters -> use_cases;
    use_cases -> entities;
  }
} 
```

</center>

---

# Fullstack-модуль

<center>

!!!include(_two_modules.md)!!!

</center>

---

# Entites

---
<!-- header: Entites -->

# Дано

- общие для всех модулей
- общие для будующих сервисов
- ни от чего не зависят

---

# Следовательно

- вынесены на верхний уровень
- оформлены, как gem
- тестируются отдельно

---

# Entities

<table><tr><td>

<pre class='folders'>
my_app/<span style="background: #FEFBBA">entities</span>
my_app/<span style="background: #FEFBBA">entities</span>/lib
my_app/<span style="background: #FEFBBA">entities</span>/entities.gemspec
</pre>

</td><td>

!!!include(_module.md)!!!

</td></tr></table>

---

# Entities

```ruby
module MyApp::Entities
  class Product; end
  class Client; end
end
```

---

# Модули

---
<!-- header: Модули -->

# Дано

- Full-stack
- должны подключаться в главное приложение
- будут выделены в отдельные сервисы

---

# Следовательно

- содержат в себе все слои (use_cases, adapters, frameworks)
- совпадают с ограниченными контекстами (DDD)
- тестируются отдельно

---

# Модули

<table><tr><td>

<pre class='folders'>
my_app/modules
my_app/modules/orders
my_app/modules/accounts
</pre>

</td><td>

!!!include(_two_modules.md)!!!

</td></tr></table>

---
<!-- header: "" -->

# Use Cases
Как часть модуля

---
<!-- header: Модули. Use Cases -->

# Дано

- используют entities
- не зависят от деталей приложения
- могут использоваться в нескольких external-частях модуля (api, job, listener)
- реализуют бизнес-логику модуля

---

# Следовательно

- оформлены, как gem
- используют entities gem
- тестируются отдельно
- вынесены на верхний уровень модуля

---

# Use Cases

<table><tr><td>

<pre class='folders'>
my_app/modules
my_app/modules/orders
my_app/modules/orders/<span style="background: #FFA09B">lib</span>
my_app/modules/orders/<span style="background: #FFA09B">lib/order_creator.rb</span>
my_app/modules/orders/<span style="background: #FFA09B">lib/cart.rb</span>
my_app/modules/orders/orders.gemspec
</pre>

</td><td>

!!!include(_module.md)!!!

</td></tr></table>


---

# Use Cases

```ruby
module MyApp::Orders
  class OrderCreator; end
  class Cart; end
end
```


---
<!-- header: "" -->

# Модуль

*Frameworks & Drivers*

<table><tr><td>

<pre class='folders'>
my_app/modules
my_app/modules/orders
my_app/modules/orders/<span style="background: #A4D8FF">external</span>
my_app/modules/orders/lib
my_app/modules/orders/orders.gemspec
</pre>

</td><td>

!!!include(_module.md)!!!

</td></tr></table>


---

# Модуль

*Frameworks & Drivers*

<table><tr><td>

<pre class='folders'>
orders/<span style="background: #A4D8FF">external</span> (engine)
orders/<span style="background: #A4D8FF">external/app/controllers</span>
orders/<span style="background: #A4D8FF">external/app/</span><span style="background: #A2FDBA">gateways</span>
orders/<span style="background: #A4D8FF">external/app/models</span>
orders/<span style="background: #A4D8FF">external/app/</span><span style="background: #A2FDBA">presenters</span>
orders/<span style="background: #A4D8FF">external/views</span>
orders/<span style="background: #A4D8FF">external/workers</span>
</pre>

</td><td>

!!!include(_module.md)!!!

</td></tr></table>


---

# Приложение


<table><tr><td>

<pre class='folders'>
<span style="background: #FEFBBA">entities</span>
<span style="background: #A4D8FF">external</span> # <-- Rails
modules/orders/<span style="background: #A4D8FF">external</span> # <-- engine
modules/orders/<span style="background: #FFA09B">lib</span>
modules/accounts/<span style="background: #A4D8FF">external</span> # <-- engine
modules/accounts/<span style="background: #FFA09B">lib</span>
</pre>

</td><td>

!!!include(_module.md)!!!

</td></tr></table>

---

# Приложение

<table><tr><td>

```plantuml
digraph G {
  node [shape="box" style="filled" width="2" fillcolor="white"]

  entities [label="Entities gem" fillcolor="#FEFBBA"];

  orders_gem [label="Orders gem" fillcolor="#FFA09B"]
  orders_rails_engine [label="Orders Rails Engine" fillcolor="#A4D8FF:#A2FDBA"]

  orders_gem -> entities;
  orders_rails_engine -> orders_gem;

  accounts_gem [label="Accounts gem" fillcolor="#FFA09B"]
  accounts_rails_engine [label="Accounts Rails Engine" fillcolor="#A4D8FF:#A2FDBA"]

  accounts_gem -> entities;
  accounts_rails_engine -> accounts_gem;

  rails [label="Rails" fillcolor="#A4D8FF"];
  rails -> orders_rails_engine;
  rails -> accounts_rails_engine;
} 
```

</td><td>

!!!include(_module.md)!!!

</td></tr></table>

---

# Спасибо!
