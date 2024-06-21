---
marp: true
paginate: true
---
<style>
  img {
    display: block;
    max-height: 100%;
    max-width: 80%;
  }

  h1, p, ul li { color: black; }
  pre { border: 0px; background: white; }

  footer { color: #bbb }
  footer a { color: #bbb }
</style>

<!-- _paginate: skip -->

# Rich Domain Model

---

# What?

* Rich Domain Model vs Active Record
* Interactor
* Repository
* SRP
* Coupling

---

# Why?

* медленные тесты
* раздувание модели
* связанность кода и БД

---

# How to fix

---

# Active Record

```ruby
directory = Directory.find(id)
directory.build_file(name: "hello.txt")
directory.save
```

---

# Rich Domain Model

```ruby
directory = dirs.find(id)
directory.new_file(name: "hello.txt")
dirs.save directory
```

---

# Issues

* сложно
* обучение
* не работают коробочные решения

---

# Summary

---

# Links

* <https://github.com/sergio-fry/slides/template>

