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

Сергей Удалов » ecom.tech

---

<!-- _paginate: skip -->

# Кто я такой?

- техлид в ecom.tech
- публичные выступления
- @SergeiUdalov

---

<!-- _paginate: skip -->

![bg](img/clean-arch-2019.jpeg)

---

<!-- footer: "Rich Domain Model » @SergeiUdalov » ecom.tech » bit.ly/3XYL0Xi" -->

# Digital Asset Management

- 1.2M files, 11TB
- 4854 lines of code (+8344 RSpec)
- 98.48% coverage
- команда 9 человек

---

```ruby
SimpleCov.start do
  add_filter "bin"
  add_filter "config"
  add_filter "db"
end
```

---

# Зачем?

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
    <mark>0.02908</mark> seconds ./spec/domain/directory_spec.rb:28
    0.02596 seconds ./spec/domain/file_spec.rb:74
    0.02442 seconds ./spec/domain/file_spec.rb:67
    0.0204 seconds ./spec/outbox/file/create_event_spec.rb:27
    0.01876 seconds ./spec/interactors/google_drive/create_spec.rb:27
    0.01795 seconds ./spec/interactors/google_drive/update_spec.rb:30
</pre>

---

<style scoped>
  img {
    width: 40%;
  }
  td,table,tr {
    border: 0px
  }
</style>

<table>
  <tr>
    <td width="50%">

```plantuml
skinparam monochrome true
allow_mixing
scale 2
top to bottom direction

rectangle Model
rectangle View
rectangle Controller

Controller -left- View


View -up- Model 
Controller -up- Model 
```

  </td>
  <td>

  ![](img/mvc-qr.png)
  </td>
  </tr>
</table>

---

# Domain

---

<!-- _header: Active Record -->

```ruby
class Article < ApplicationRecord
  def rating
    views + comments.count * 5
  end

  def publish!
    self.update published_at: Time.now
    notify_subscribers
  end

  def as_json
    { id:, title:, published_at: published_at.rfc3339, body: body_html}
  end
end
```

---

<!-- _header: Active Record -->

```ruby
class Article < ApplicationRecord
  # CalculateArticleRatingInteractor
  def rating

  # PublishArticleInteractor
  def publish!

  # ArticlePresenter
  def as_json
end
```

---

<!-- _header: Active Record -->

```ruby
class Article < ApplicationRecord
end
```

---

<!-- _header: Active Record -->

# **Anemic** Domain Model

<br />

> The fundamental horror of this anti-pattern is that it's so contrary to the basic idea of object-oriented design; which is to combine data and process together.
— *Martin Fowler*

<br />

<img src="img/martin-fowler.jpeg" width="100.2em" style="border-radius:50%;" align=right />

---

<!-- _header: Active Record -->

```ruby
RSpec.describe ArticlesController do 
  context do 
    let!(:article) { create(:article, published_at: 1.minute.ago, ...) }

    example do 
      post publish_article_url(article.id)
      expect(respose.body).to match /Article already published/
    end
  end
end
```

---

<!-- _header: Active Record -->

# XXX

```ruby
before {
  allow(Article).to receive(:find_by)
                      .with(slug: "taken-slug")
                      .and_return(build(:article))
}
```

---

# Active Record

---

<style scoped>
  img {
    width: 40%;
  }
</style>

# David Heinemeier Hansson

<img src="img/dhh.jpeg" width="40%" style="border-radius:50%;"  />

---

# Мартин Фаулер

<img src="img/martin-fowler.jpeg" width="40%" style="border-radius:50%;"  />

![bg right](img/eaa_book.jpeg)

---

> Active Record is a good choice for domain logic that isn’t too
complex, such as creates, reads, updates, and deletes.
— *Martin Fowler*

<br />

<img src="img/martin-fowler.jpeg" width="100.2em" style="border-radius:50%;" align=right />

---

# Domain Model

aka **Rich** Domain Model

---

# Data Mapper

> A layer of Mappers (473) that moves data between objects
and a database while keeping them independent of
each other and the mapper itself.

---

# Repository

> Mediates between the domain and data mapping layers using
a collection-like interface for accessing domain objects.

---

<center>

```plantuml
skinparam monochrome true
allow_mixing
scale 2

database DB

class Article {
  +save()
  +find(id)
  +publish()
}

Article .right.> DB

```

</center>

---

<!-- _header: Domain Model -->

<center>

```plantuml
skinparam monochrome true
allow_mixing
scale 2


database "DB" as db

class "Article" as article_domain {
  published_at
  +rating()
  +publish()
}

class ArticlesRepository {
  +save(entity)
  +find(id): Article
}

ArticlesRepository .right.> db
ArticlesRepository .left.> article_domain
```

</center>

---

<!-- _header: Domain Model -->

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
    self.update published_at: Time.now
    notify_subscribers
  end

  def as_json
    { id:, title:, published_at: published_at.rfc3339, body: body_html}
  end
end
```

---

<!-- _header: Domain Model -->

```ruby
class Article
end
```

---

<!-- _header: Domain Model -->

```ruby
module Domain
  class Article
    def initialize(id:, title:, body:, views: 0,
                  published_at: nil, comments: [], events: [])
      @id = id 
      @title = title
      @body = body
      @views = views
      @published_at = published_at
      @comments = comments
      @events = events
    end
  end
end
```

---

<!-- _header: Domain Model -->

```ruby
module Domain
  class Article
    def initialize # ...

    def rating = @views + @comments.size * 5

    def publish
      @published_at = Time.now
      @events << ArticlePublishedEvent.new(article: self, dt: @published_at)
    end
  end
end
```

---

<!-- _header: Domain Model -->

<pre>
class ArticlesRepository
  def find(id)
    record = Article.find(id)

    Domain::Article.new(id: record.id, views: record.views,
      title: record.title, <mark>body: record.content</mark>,
      published_at: record.published_at, comments: <mark>ArticleComments.new(record)</mark>)
  end
end
</pre>

---

<!-- _header: Domain Model -->

```ruby
class ArticlesRepository
  def save(entity)
    record = Article.find_or_initialize_by(id: entity.id)

    record.assign_attributes(views: entity.views, title: entity.title,
      content: entity.body, published_at: entity.published_at
    )

    update_comments(entity.comments)

    record.save!
  end
end
```

---

<!-- _header: Domain Model -->

# Загрузка модели (1/3)

<pre>
class PublishArticleInteractor
  include Import[repo: "repositories.articles"]

  def call(id)
    <mark>article = repo.find(id)</mark>
  end
end
</pre>

---

<!-- _header: Domain Model -->

# Манипуляция с моделью (2/3)

<pre>
class PublishArticleInteractor
  include Import[repo: "repositories.articles"]

  def call(id)
    article = repo.find(id)
    <mark>article.publish</mark>
  end
end
</pre>

---

<!-- _header: Domain Model -->

# Сохранение (3/3)

<pre>
class PublishArticleInteractor
  include Import[repo: "repositories.articles"]

  def call(id)
    article = repo.find(id)
    article.publish
    <mark>repo.save article</mark>
  end
end
</pre>

---

<!-- _header: Domain Model -->

# Тестирование

```ruby
let(:article) { Article.new(id: 1, ...) }

describe "#publish" do
  before { article.publish }
  it { expect(article.published_at).to eq Time.now }
  it { expect(article.events).to include(...) }
end
```

---

<!-- _header: Domain Model -->

# Тестирование

```ruby
let(:article) { Article.new(id: 1, views:, comments:, ...) }

describe "#rating" do
  let(:views) { 1 }
  let(:comments) { [Comment.new(text: "hello", ...)] }
  it { expect(article.rating).to eq 6 }
end
```

---

<!-- _header: Domain Model -->

```ruby
RSpec.describe ArticlesController do 
  let(:articles) { Testing::FakeArticlesRepository.new }
  before { DependenciesContainer.stub("repositories.articles", articles) }
  after { DependenciesContainer.unstub("repositories.articles") }

  context do 
    let(article) { Article.new(id: 1, published_at: 1.minute.ago, ...) }
    before { articles.save article }

    example do 
      post pubslish_article_url(article.id)
      expect(respose.body).to match /Article already published/
    end
  end
end
```

---

<!-- _header: Domain Model -->

# Fake Repository

```ruby
module Testing
  class FakeArticlesRepository
    def initialize
      @entities = {}
    end

    def find(id) = @entities[id]
    def save(entity) = @entities[entity.id] = entity
  end
end
```

---

# Что еще?

---

# Параллельная запись

```ruby
class ArticlesRepository
  def save(entity)
    record = Article.find_or_initialize_by(id: entity.id)

    record.assign_attributes(views: entity.views, title: entity.title,
      content: entity.body, published_at: entity.published_at
    )

    update_comments(entity.comments)

    record.save!
  end
end
```

---

<!-- _header: Dirty -->

<style scoped>
  img {
    width1: 80%;
  }
</style>

<center>

```plantuml

actor       Bob
actor       Alice
participant    Rails
database    DB

Alice -> Rails: [A] update title
Rails -> DB: [A] find
DB -> Rails: [A] attrs
Bob -> Rails: [B] update body
Rails -> DB: [B] find

DB -> Rails: [B] attrs
note right
  получает старое
  значение title
end note

Rails -> DB: [A] update
Rails -> DB: [B] update
note right
  сохраняет новый body
  и затирает title
end note
```

</center>

---

<!-- _header: Dirty -->

```ruby
class ArticlesRepository
  def save(entity)
    # ..
    update_comments(record, entity) if entity.changed?(:comments)

    record.save!
    entity.changes_applied
  end
end
```

---

<!-- _header: Dirty -->

# ActiveModel::Dirty

```ruby
class Article
  include ActiveModel::Dirty

  define_attribute_methods :title

  def initialize(title:)
    @title = title
  end

  def title=(val)
    name_will_change! unless val == @title
    @title = val
  end
end

```

---

<!-- _header: Dirty -->

```ruby
class Article
  include Dirty

  def initialize(title:)
    @title = title
  end

  def title=(val)
    @title = val
  end
end
```

---

<!-- _header: Dirty -->

```ruby
article.changed? # => false

article.title = "New Title"
article.changed? # => true
article.changed?(:title) # => true

article.changes_applied
article.changed? # => false

```

---

<!-- _header: Dirty -->

# Как это работает?

```ruby

module Dirty
  extend ActiveSupport::Concern

  included do
    def initialize(**args)
      super
      @changes = EntityChanges.new(self)
      @changes.commit
    end
```

<https://bit.ly/4ekmQMT>

---

# Relation

<!-- Для больших коллекций -->

---

<!-- _header: Relation -->

```ruby
class ArticleComments
  include Enumerable

  def initialize(record)
    @record = record
  end

  def each
    @record.comments.each do |record|
      yield comments_repo.from_record(record)
    end
  end
end
```

---

<!-- _header: Relation -->

<pre>
class ArticleComments
  include Enumerable

  def initialize(record)
    @record = record
    <mark>@new_comments = []</mark>
  end

  <mark>def <<(new_comment) = @new_comments << new_comment</mark>

  def each
    <mark>@new_comments.each { |comment| yield comment }</mark>
    @record.comments.each do |record|
      yield comments_repo.from_record(record)
    end
  end
end
</pre>

---

# Identity Map

---

```ruby
article = repo.find(id)
article2 = repo.find(id)

article.object_id == article2.object_id # => true
```

<https://bit.ly/3Nn2qXP>

---

<img src="img/rom-rb.svg" />
<br/>

**Ruby Object Mapper** is an open-source persistence<br/> and mapping toolkit for Ruby built for speed and simplicity.

<https://rom-rb.org/>

---

> If you have fairly simple business logic, you probably
won’t need a Domain Model (116) or a Data Mapper
— *Martin Fowler*

<br />

<img src="img/martin-fowler.jpeg" width="100.2em" style="border-radius:50%;" align=right />

---

<center>

```plantuml
skinparam monochrome true
allow_mixing
scale 2

database DB

class PublishArticle {
  +publish()
}

class ArticleRating {
  +rating()
}

class Article {
  +save()
  +find(id)
}

PublishArticle ..> Article
ArticleRating ..> Article

Article .right.> DB

```

</center>

---

<style scoped>
  .kroki-image-container {
    width: 60%;
  }
</style>

<center>

```plantuml
skinparam monochrome true
allow_mixing
scale 2

database DB

package Domain {
  class Article {
  }

  class Comment {
  }

  class Subscription {
  }

  class User {
  }

  Article ..> Comment
  Comment ..> User
  Subscription .left.> Article
  Subscription ..> User
}


ArticlesRepository ..> DB
ArticlesRepository ..> Article
CommentsRepository ..> Comment
ArticlesRepository ..> CommentsRepository
CommentsRepository ..> DB

```

</center>

---

# Итоги

- Active Record
- Anemic Model
- Rich Domain Model

<!--
1. зачем?
2. как понять, что не rich?
3. как начать?
-->

---

<style scoped>
  img {
    width: 80%;
  }
  td,table,tr {
    border: 0px
  }
</style>

<table>
  <tr>
    <td width="70%">

# Ссылки

- <https://bit.ly/4eomrsQ> - PEAA Book
- <https://bit.ly/4eu1tIp> - Anemic Domain Model
- YouTube @SergeiUdalov

  </td>
  <td>

![](img/feedback.jpeg)
  </td>
  </tr>
</table>
