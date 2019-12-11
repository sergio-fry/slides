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

```bash
app/entities (gem)
```

---

# Module


```bash
app/modules/orders
app/modules/accounts
```
