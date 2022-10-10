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

Bob Martin https://web.archive.org/web/20150905081105/http://www.objectmentor.com/resources/articles/ocp.pdf


---

```plantuml

class Product {
  +price()
}

```

---

```ruby
class Product
  def price
    if user.lucky?
      @price * 0.9
    else
      @price
    end
  end
end
```

---

# Inheritance

```plantuml
class Product {
  +price()
}

class ProductWithBonusPrice {
  +price()
}

ProductWithBonusPrice -up-|> Product
```


---

# Composition


```plantuml
class Product {
  +price()
}

class Price {
  +value()
}

Product --* Price
```

---

# Dependecy Injection


```plantuml
class Product {
  +price()
}

interface Price {
  +value()
}

Product --* Price
```

---

# History

* large gem 
* extract core
* extend with modules
