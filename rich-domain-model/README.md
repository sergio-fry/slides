---
marp: true
paginate: true
---

<!-- _paginate: skip -->

# Rich Domain Model

---

# What?

---

# Why?

* связанность кода и БД
* раздувание модели
* медленные тесты
* интересно

---

# Plan

---

# Active Record

```ruby
class Article < ApplicationRecord
  def rating
    views + comments.count * 5
  end

  def publish!
    self.published_at = Time.now
    notify_subscribers
  end

  def as_json
    { id:, title:, published_at: published_at.rfc3339, body: body_html}
  end
end
```

---

# Active Record

```ruby
class Article < ApplicationRecord
  # CalculateArticleRatingInteractor
  def rating
    views + comments.count * 5
  end

  # PublishArticleInteractor
  def publish!
    self.published_at = Time.now
    notify_subscribers
  end

  # ArticlePresenter
  def as_json
    { id:, title:, published_at: published_at.rfc3339, body: body_html}
  end
end
```

---

# Anemic Domain Model

```ruby
class Article < ApplicationRecord
end
```

---

# Тестирование

```ruby
RSpec.describe ArticlesController do 
  context do 
    before { create(:article, slug: "taken-slug") }

    example do 
      post articles_url, params: { article: { slug: "taken-slug" } }
      expect(respose.body).to match /Slug is already taken/
    end
  end
end
```

---

# XXX

```ruby
before {
  allow(Article).to receive(:find_by)
                      .with(slig: "taken-slug")
                      .and_return(build(:article))
}
```


---

# Issues

* сложно
* обучение
* не работают коробочные решения

---

# Other

* code smells, как понять, что не rich
* repository UML
* testing example
* DDD
* rom-rb

---

# Summary

---

# Links

* <https://github.com/sergio-fry/slides/template>

