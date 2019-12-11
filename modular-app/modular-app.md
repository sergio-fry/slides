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

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

<td>
<pre>
app/<span style="background: #FEFBBA">entities</span>
app/<span style="background: #FEFBBA">entities</span>/lib
app/<span style="background: #FEFBBA">entities</span>/entities.gemspec
</pre>
</td>

</tr>
</table>

---

# Modules

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

<td>
<pre>
app/modules
app/modules/orders
app/modules/accounts
</pre>
</td>

</tr>
</table>


---

# Module
*Use Cases*

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

<td>
<pre>
app/modules
app/modules/orders
app/modules/orders/lib
app/modules/orders/lib/<span style="background: #FFA09B">order_creator.rb</span>
app/modules/orders/lib/<span style="background: #FFA09B">cart.rb</span>
app/modules/orders/orders.gemspec
</pre>

</td>

</tr>
</table>


---

# Module

*Adapters*

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

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

</td>

</tr>
</table>

---

# Module

*Frameworks & Drivers*

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

<td>
<pre>
app/modules
app/modules/orders
app/modules/orders/<span style="background: #A4D8FF">external</span>
app/modules/orders/lib
app/modules/orders/orders.gemspec
</pre>

</td>

</tr>
</table>

---

# Module

*Adapters*

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

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

</td>

</tr>
</table>

---

# Module

*Frameworks & Drivers*

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

<td>
<pre>
app/modules
app/modules/orders
app/modules/orders/<span style="background: #A4D8FF">external</span>
app/modules/orders/lib
app/modules/orders/orders.gemspec
</pre>

</td>

</tr>
</table>

---

# Module

*Frameworks & Drivers*

<table>
<tr>

<td>

![height:10em](img/module.png)

</td>

<td>
<pre>
orders/<span style="background: #A4D8FF">external</span>
orders/<span style="background: #A4D8FF">external/rails_engine</span>
orders/<span style="background: #A4D8FF">external/rake_tasks</span>
orders/<span style="background: #A4D8FF">external/workers</span>
</pre>

</td>

</tr>
</table>
