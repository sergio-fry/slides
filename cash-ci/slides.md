---
paginate: true
theme: gaia
---
<style>
  section {
    background: white;
  }
</style>
<!--
_paginate: false
_class: lead
-->


# Cash. CI/CD

Sergei O. Udalov

---

<!-- footer: Cash. CI/CD. Sergei O. Udalov -->

# Why?

* quality check
* delivery
* documentation


---

# Quality Check

* test + coverage
* lint
* security issues

---

# Delivery

* build image
* continious deliver
* manual deployments

---

# Stages

<img src="img/stages.png"/>


---


# Instant Results

<img src="img/results.png" height="70%" />


---

# Instant Results

```yaml

  script:
    - rubocop || true
    - rubocop --format junit --display-only-failed --out rubocop.xml

  artifacts:
    paths:
      - rubocop.xml
    reports:
      junit: rubocop.xml
```

---

# Deployment History

<img src="img/deployment_history.png" width="90%" />

---

# Deployment History

```yaml
deploy:staging1:
  stage: deploy
  needs: ["current-image"]
  when: manual
  interruptible: true
  environment:
    name: st1

```

--- 

# DRY

```yaml
current-image:
  <<: *docker
  stage: build
  script:
    - docker build --pull --build-arg BASE_APP_IMAGE=$IMAGE:base-$BA...
    - docker push $IMAGE:$CI_COMMIT_SHORT_SHA
```


---


# Documentation

```yaml
before_script:
  - bundle exec rake db:create
  - bundle exec rake db:setup:all

script:
  - bundle exec rspec spec
```

---


# Спасибо!

--- 

# Bonus


---

# Gitlab CI + Tower
