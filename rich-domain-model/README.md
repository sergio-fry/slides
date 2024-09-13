---
marp: true
paginate: true
---

<style>
  img {
    display: block;
  }

  h1, p, ul li { color: black; }
  pre { border: 0px; background: white; }

  footer { color: #bbb }
  footer a { color: #bbb }
</style>

<!-- _paginate: skip -->

# Rich Domain Model

---

<!-- footer: rich domain model -->

# Digital Asset Management

* 1.2M files, 11TB
* 4854 lines of code (+8344 RSpec)
* 98.48% coverage
* 2 разработчика

---

<pre>
$ rspec -c --tag fast
Run options: include {:fast=>true}

Randomized with seed 47124
............................................................................
............................................................................
............................................................................
............................................................................
............


Finished in <mark>2.07</mark> seconds (files took 2.16 seconds to load)
317 examples, 0 failures, 0 pending

Coverage report generated for RSpec to
/Users/sergei/code/dam/dam-api/coverage/coverage.xml.
3172 / 4854 LOC (<mark>65.34%</mark>) covered
</pre>

---

<pre>
Top 10 slowest examples (0.68232 seconds, <mark>35.8%</mark> of total time):
    0.15203 seconds ./spec/domain/kinds/image_spec.rb:27
    0.13857 seconds ./spec/interactors/files/create_spec.rb:186
    0.13542 seconds ./spec/repositories/assets_in_directory/filter_spec.rb:39
    0.11972 seconds ./spec/repositories/assets_in_directory/filter_spec.rb:22
    0.02908 seconds ./spec/domain/directory_spec.rb:28
    0.02596 seconds ./spec/domain/file_spec.rb:74
    0.02442 seconds ./spec/domain/file_spec.rb:67
    0.0204 seconds ./spec/outbox/file/create_event_spec.rb:27
    0.01876 seconds ./spec/interactors/google_drive/create_spec.rb:27
    <mark>0.01795 seconds</mark> ./spec/interactors/google_drive/update_spec.rb:30
</pre>

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
                      .with(slug: "taken-slug")
                      .and_return(build(:article))
}
```

---


<style scoped>
  img {
    width: 40%;
    box-shadow: 10px 5px 5px #aaa;
  }
</style>


![](img/eaa_book.jpeg)


---

<style scoped>
  img {
    width: 40%;
  }
</style>

# Мартин Фаулер


![](img/martin-fowler.jpeg)

---

# Active Record

> Active Record is a good choice for domain logic that isn’t too complex, such as
creates, reads, updates, and deletes.  - **Martin Fowler**


---

# Active Record

> Active Record has the primary advantage of simplicity.  - **Martin Fowler**

---

# Active Record

> Another argument against Active Record is the fact that it couples the object
design to the database design. This makes it more difficult to refactor either
design as a project goes forward.  - **Martin Fowler**

---

# Data Mapper

> A layer of Mappers (473) that moves data between objects
and a database while keeping them independent of
each other and the mapper itself.


---

> If you have fairly simple business logic, you probably won’t need a Domain
Model (116) or a Data Mapper

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

# Жизненный цикл

1. загрузка модели
2. манипуляция с моделью
3. сохранение модели

---


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

```ruby
class Article
end
```

---


```ruby
class Article
  def initialize(id:, title:, body:, views: 0, published_at: nil, comments: [])
    @id = id 
    @title = title
    @body = body
    @views = views
    @published_at = published_at
    @comments = comments
  end
end
```

---


```ruby
class Article
  def initialize(id:, title:, body:, views: 0, published_at: nil, comments: [])
    @id = id 
    @title = title
    @body = body
    @views = views
    @published_at = published_at
    @comments = comments
  end

  def rating = @views + @comments.size * 5

  def publish
    @published_at = Time.now
    notify_subscribers
  end
end
```

---

```ruby
class ArticlesRepository
  def find(id)
    record = Database::Article.find(id)

    Article.new(id: record.id, views: record.views,
      title: record.title, body: record.body,
      published_at: record.published_at, comments(record))
  end
end
```

---

```ruby

# 1. загрузка модели
article = repo.find(id)

# 2. манипуляция с моделью
article.publish

# 3. сохранение модели
repo.save article

```

---

# Тестирование

```ruby
let(:article) { Article.new(id: 1, ...) }

describe "#publish" do
  before { article.publish }
  it { expect(article.published_at).to eq Time.now }
end

```

---

# Тестирование

```ruby
let(:article) { Article.new(id: 1, views:, comments:, ...) }

describe "#rating" do
  let(:views) { 1 }
  let(:comments) { [double(:comment)] }
  it { expect(article.rating).to eq 6 }
end

```

---

```ruby



RSpec.describe ArticlesController do 
  let(:articles) { Testing::FakeArticlesRepository.new }
  before { DependenciesContainer.stub(:articles, articles) }
  after { DependenciesContainer.unstub(:articles) }

  context do 
    before { articles.save Article.new(id: 1, slug: "taken-slug", ...) }

    example do 
      post articles_url, params: { article: { slug: "taken-slug" } }
      expect(respose.body).to match /Slug is already taken/
    end
  end
end
```

---

# Что еще?

* Dirty
* Relations
* IdentityMap
* PubSub

---

# Issues

* сложно
* обучение
* не работают коробочные решения

---

# Other

---

# Summary

---

# Links

- <https://martinfowler.com/bliki/AnemicDomainModel.html>

