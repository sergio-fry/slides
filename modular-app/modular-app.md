---
marp: true
theme: uncover
paginate: true
backgroundColor: #fff
---


<!-- _paginate: false -->

# Modular Ruby app

Sergei O. Udalov

---

# Clean Architecture

![](img/clean_architecture.jpeg)


---

# Fullstack Module

<div>

@startuml
skinparam dpi 200

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
@enduml

</div>

---

# Fullstack Module

<div>

@startuml
skinparam dpi 200

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
@enduml

</div>


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

<pre>
app/modules
app/modules/orders
app/modules/orders/lib
app/modules/orders/lib/<span style="background: #FFA09B">order_creator.rb</span>
app/modules/orders/lib/<span style="background: #FFA09B">cart.rb</span>
app/modules/orders/orders.gemspec
</pre>



---

# Module

*Adapters*


<td>
<pre>
app/modules
app/modules/orders
app/modules/orders/lib
app/modules/orders/lib/<span style="background: #A2FDBA">adapters</span>
app/modules/orders/lib/<span style="background: #A2FDBA">adapters/orders_repo.rb</span>
app/modules/orders/lib/<span style="background: #A2FDBA">adapters/order_serializer.rb</span>
app/modules/orders/orders.gemspec
</pre>


---

# Module

*Frameworks & Drivers*

<pre>
app/modules
app/modules/orders
app/modules/orders/<span style="background: #A4D8FF">external</span>
app/modules/orders/lib
app/modules/orders/orders.gemspec
</pre>


---

# Module

*Frameworks & Drivers*

<pre>
orders/<span style="background: #A4D8FF">external</span>
orders/<span style="background: #A4D8FF">external/rails_engine</span>
orders/<span style="background: #A4D8FF">external/rake_tasks</span>
orders/<span style="background: #A4D8FF">external/workers</span>
</pre>


---

# Application


<table>
<tr>

<td>

@startuml
skinparam dpi 200

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
@enduml

</td>

<td>
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
</td>

</tr>
</table>

---

# Dependencies

<div>

@startuml
skinparam dpi 200

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
@enduml

</div>
