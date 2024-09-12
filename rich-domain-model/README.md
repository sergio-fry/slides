---
marp: true
paginate: true
---

<style>
  img {
    display: block;
    max-height: 100%;
    max-width: 80%;
    width: auto;
    height: auto;
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

---

```bash
$ rspec -c --tag fast
Run options: include {:fast=>true}

Randomized with seed 47124
................................................................................
................................................................................
................................................................................
............................................................................


Finished in 2.07 seconds (files took 2.16 seconds to load)
317 examples, 0 failures, 0 pending

Randomized with seed 47124

Coverage report generated for RSpec to /Users/sergei/code/dam/dam-api/coverage/coverage.xml. 3172 / 4119 LOC (77.01%) covered
```

---

```bash
Top 10 slowest examples (0.68232 seconds, 35.8% of total time):
    0.15203 seconds ./spec/domain/kinds/image_spec.rb:27
    0.13857 seconds ./spec/interactors/files/create_spec.rb:186
    0.13542 seconds ./spec/repositories/assets_in_directory/filter_spec.rb:39
    0.11972 seconds ./spec/repositories/assets_in_directory/filter_spec.rb:22
    0.02908 seconds ./spec/domain/directory_spec.rb:28
    0.02596 seconds ./spec/domain/file_spec.rb:74
    0.02442 seconds ./spec/domain/file_spec.rb:67
    0.0204 seconds ./spec/outbox/file/create_event_spec.rb:27
    0.01876 seconds ./spec/interactors/google_drive/create_spec.rb:27
    0.01795 seconds ./spec/interactors/google_drive/update_spec.rb:30
```

---

# Why?

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

# Как быть?


---


# Patterns of Enterprise Application Architecture

2003 

---


<center>

```plantuml
allow_mixing

database "DB" as db1
database "DB" as db2

package ActiveRecrod {
  class "Article" as article_ar {
    +save()
    +find(id)
    +publish()
  }

  article_ar ..> db1
}

package "Data Mapper" {
  class "Article" as article_domain {
    published_at
    +publish()
  }

  class ArticlesMapper {
    +save(article)
    +find(id): Article
  }

  ArticlesMapper ..> db2
  ArticlesMapper .up.> article_domain
}

```

</center>

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

