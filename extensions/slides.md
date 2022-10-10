---
paginate: true
class: lead
marp: true
---
<style>
  section {
    background: #f2f2f2;
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


# Принцип открытости/закрытости


---

# SOLID

O - open-closed principle

---

```ruby
class Calculate
  def initialize(a, b)
    @a, @b = a, b
  end

  def value
    @a + @b
  end
end
```

---


```plantuml
class Calculate {
  +call(a, b)
}


```

