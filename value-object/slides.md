---
paginate: true
class: lead
marp: true
---
<style>
  section {
  }
  h1,body,li,p { color: black; }

  h1 {
    text-decoration: underline;
    text-decoration-color: #FF5028;
    text-underline-offset: 0.3em;
    text-decoration-thickness: 0.1em;
    padding-bottom: 0.3em;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-width: 90%;
  }
</style>
<!--
_paginate: false
_class: lead
-->


# Value Object

Sergei O. Udalov

---

# Intro

* Value Object
* Data (Ruby 3.2 RC)
* Pros / Cons
* Plain Ruby


--- 

# Entity


---

<!-- 
footer: Entity
-->

# Different

```ruby
user1 = User.new(1)
user1.update(name: 'Ivan')

user2 = User.new(2)
user2.update(name: 'Ivan')

user1 == user2
# => false
```

---

# The Same

```ruby
user1 = User.new(1)
user1.update(name: 'Ivan')

user2 = User.new(1)
user2.update(name: 'Petr')

user1 == user2
# => true
```

---
<!-- 
footer: ""
-->
---

# Summary


---

# Links

---

# Thanks!
