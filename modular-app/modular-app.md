---
marp: true
theme: uncover
paginate: true
backgroundColor: #ddd
---


<!-- _paginate: false -->

# Modular Ruby app

Sergei O. Udalov

---
<!-- _backgroundColor: white -->


# Clean Architecture

![](img/clean_architecture.jpeg)


---

# Fullstack Module


- Entites
- Use Cases
- Interface Adapters
- Frameworks & Drivers

---

# Fullstack Module

<div>

@startuml
skinparam dpi 100

component "Orders"  {
  rectangle "Entites" as entities #FEFBBA
  rectangle "Use Cases" as use_cases #FFA09B
  rectangle "Interface Adapters" as adapters #A2FDBA
  rectangle "Frameworks & Drivers" as external #A4D8FF

  use_cases -> entities
  adapters -> use_cases
  external -> adapters
}

@enduml

</div>

<div>

@startuml
skinparam dpi 100

component "Accounts"  {
  rectangle "Entites" as entities #FEFBBA
  rectangle "Use Cases" as use_cases #FFA09B
  rectangle "Interface Adapters" as adapters #A2FDBA
  rectangle "Frameworks & Drivers" as external #A4D8FF

  use_cases -> entities
  adapters -> use_cases
  external -> adapters
}

@enduml

</div>
