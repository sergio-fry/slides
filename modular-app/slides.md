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
</style>

<!--
_paginate: false
class: lead
-->

# Modular Ruby app

Sergei O. Udalov

---

# Clean Architecture

![height:15em](img/clean_architecture.jpeg)


---

# Fullstack Module

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

# Fullstack Module

<center>

```plantuml
digraph G {
  node [shape="box" style="filled" width="2"]

  subgraph cluster3 {
    entities [label="Entites" fillcolor="#FEFBBA" width="3"];
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

  subgraph cluster2 {
    label = "Accounts";

    use_cases2 [label="Use Cases" fillcolor="#FFA09B"]
    interface_adapters2 [label="Interface Adapters" fillcolor="#A2FDBA"]
    framework_drivers2 [label="Frameworks & Drivers" fillcolor="#A4D8FF"]

    framework_drivers2 -> interface_adapters2;
		interface_adapters2 -> use_cases2;
    use_cases2 -> entities;
	}
} 
```

</center>


---

# Entities

<pre>
app/<span style="background: #FEFBBA">entities</span>
app/<span style="background: #FEFBBA">entities</span>/lib
app/<span style="background: #FEFBBA">entities</span>/entities.gemspec
</pre>

---

# Modules

<pre>
app/modules
app/modules/orders
app/modules/accounts
</pre>


---

# Module
*Use Cases*

<table><tr><td>

!!!include(_module.md)!!!

</td><td>

<pre>
app/modules
app/modules/orders
app/modules/orders/lib
app/modules/orders/lib/<span style="background: #FFA09B">order_creator.rb</span>
app/modules/orders/lib/<span style="background: #FFA09B">cart.rb</span>
app/modules/orders/orders.gemspec
</pre>

</td></tr></table>



---

# Module

*Adapters*


<table><tr><td>

!!!include(_module.md)!!!

</td><td>

<pre>
app/modules
app/modules/orders
app/modules/orders/lib
app/modules/orders/lib/<span style="background: #A2FDBA">adapters</span>
app/modules/orders/lib/<span style="background: #A2FDBA">adapters/orders_repo.rb</span>
app/modules/orders/lib/<span style="background: #A2FDBA">adapters/order_serializer.rb</span>
app/modules/orders/orders.gemspec
</pre>

</td></tr></table>


---

# Module

*Frameworks & Drivers*

<table><tr><td>

!!!include(_module.md)!!!

</td><td>

<pre>
app/modules
app/modules/orders
app/modules/orders/<span style="background: #A4D8FF">external</span>
app/modules/orders/lib
app/modules/orders/orders.gemspec
</pre>

</td></tr></table>


---

# Module

*Frameworks & Drivers*

<table><tr><td>

!!!include(_module.md)!!!

</td><td>

<pre>
orders/<span style="background: #A4D8FF">external</span>
orders/<span style="background: #A4D8FF">external/rails_engine</span>
orders/<span style="background: #A4D8FF">external/rake_tasks</span>
orders/<span style="background: #A4D8FF">external/workers</span>
</pre>

</td></tr></table>


---

# Application


<table><tr><td>

!!!include(_module.md)!!!

</td><td>

<pre>
<span style="background: #FEFBBA">entities</span>
<span style="background: #A4D8FF">external</span> # <-- Rails
modules/orders
modules/orders/<span style="background: #A4D8FF">external</span> # <-- engine
modules/orders/lib/<span style="background: #A2FDBA">adapters</span>
modules/orders/lib/<span style="background: #FFA09B">order_creator.rb</span>
modules/orders/lib/<span style="background: #FFA09B">cart.rb</span>
modules/accounts
</pre>

</td></tr></table>

---

# Result

<center>

```plantuml
digraph G {
  node [shape="box" style="filled" width="2" fillcolor="white"]

  entities [label="Entities gem" fillcolor="#FEFBBA"];

  orders_gem [label="Orders gem" fillcolor="#A2FDBA:#FFA09B"]
  orders_rails_engine [label="Orders Rails Engine" fillcolor="#A4D8FF"]

  orders_gem -> entities;
  orders_rails_engine -> orders_gem;

  accounts_gem [label="Accounts gem" fillcolor="#A2FDBA:#FFA09B"]
  accounts_rails_engine [label="Accounts Rails Engine" fillcolor="#A4D8FF"]

  accounts_gem -> entities;
  accounts_rails_engine -> accounts_gem;

  rails [label="Rails" fillcolor="#A4D8FF"];
  rails -> orders_rails_engine;
  rails -> accounts_rails_engine;
} 
```

</center>