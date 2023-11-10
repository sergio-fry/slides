---

marp: true
paginate: true
size: 4:3

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

  .link--source { color: #bbb; font-size: 0.5em; max-width: fit-content; }
</style>

TODO: source link fix 


<!-- _paginate: skip -->


# RSpec. Review

Sergei Udalov, PTL DAM at Samokat.tech

---

# Why?

---

# Agenda

- dry-rb
- gitlab
- hanami
- pg
- rom-rb
- rspec
- ruby-concurrency
- vcr

---

# Slide Formatting

TODO: slide formatting example

---

# How to fix

---

# Issues

---

!!!include(parts/acceptance.md)!!!
!!!include(parts/config.md)!!!
!!!include(parts/context.md)!!!
!!!include(parts/context_classes.md)!!!
!!!include(parts/expectation.md)!!!
!!!include(parts/faker.md)!!!
!!!include(parts/helpers.md)!!!
!!!include(parts/libraries.md)!!!
!!!include(parts/semantic.md)!!!


# Summary


---

# What Next?

* faraday
* rails
* sequel
* sidekiq
* ...

---

# Links

* https://github.com/sergio-fry/slides/tree/master/template

---

# Bonus

---

# How to explore

```bash
find . -type f | grep rb$ | sort --random-sort | tail -n 1 | xargs nvim
```
