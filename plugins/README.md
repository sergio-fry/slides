---
marp: true
paginate: true
---

# От монолита к экосистеме контекстов DDD

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

---

## Сергей Удалов

---

## ecom.tech

---

## DAM

Digital Assets Management

---

## О чем поговорим?

1. DDD
2. Монолит
3. Плагины
4. Ruby

---

## Микросервисы

---

## Domain Driven Design

---

## Словарь

---

## Bounded Context

---

- contexts
  - certificates
    - domain
  - media_production
    - domain
  - cms
    - domain
  - video_transcoder
    - domain

---

## Хранилка файлов

---

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    meta: {
      comment: "Отличный файл"
    }
  }
}
```

---

## Сертификаты

---

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    meta: {
      comment: "Отличный файл"
    },
    start_date: "2025-01-01",
    end_date: "2028-12-31"
  }
}
```

---

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    meta: {
      comment: "Отличный файл",
      start_date: "2025-01-01",
      end_date: "2028-12-31"
    }
  }
}
```

---

```ruby
params do
  required(:directory_id).filled(:uuid)
  required(:upload_id).filled(:uuid)
  required(:name).filled(:string)
  optional(:meta).hash
end
```

---

```ruby
params do
  required(:directory_id).filled(:uuid)
  required(:upload_id).filled(:uuid)
  required(:name).filled(:string)
  optional(:meta).hash do
    required(:comment).filled(:string)
  end

  Certifictes::Schema::Files.new(self).call
end
```

---

```ruby
# plugins/certificates/schema/file.rb

module Certifictes
  module Schema
    class File
      def initialize(schma)
        @schema = schema
      end

      def call
        @schema.instance_eval do
          optional(:certificates).hash do
            required(:start_date).filled(:date)
            required(:end_date).filled(:date)
          end
        end
      end
    end
  end
end
```

---

```ruby
{
  data: {
    directory_id: "8f4d39b2-65e9-486d-b948-db0e005b5087",
    upload_id: "3e1f164a-94f6-45d8-8dfa-665a5bed4f8c",
    name: "image.jpeg",
    meta: {
      comment: "Отличный файл",
    },
    certificates: {
      start_date: "2025-01-01",
      end_date: "2028-12-31"
    }
  }
}
```

---

```ruby
params do
  required(:directory_id).filled(:uuid)
  required(:upload_id).filled(:uuid)
  required(:name).filled(:string)
  optional(:meta).hash do
    required(:comment).filled(:string)
  end

  Certifictes::Schema::Files.new(self).call
end
```

---

```plantuml
[Plugin] --> [Core]

```

---

## Реестр плагинов

---

```ruby
params do
  required(:directory_id).filled(:uuid)
  required(:upload_id).filled(:uuid)
  required(:name).filled(:string)
  optional(:meta).hash do
    required(:comment).filled(:string)
  end

  plugins.apply_file_schema(self)
end
```

---

```ruby
Rails.root.glob("plugins/**").map do |pathname|
  plugin = Rails::Engine.find(pathname)

  plugins.register(plugin.engine_name, plugin)
end
```

---

```ruby
plugins = Plugins.new

plugins.add Certificates::Plugin.new
plugins.add CMS::Plugin.new
plugins.add MediaProduction::Plugin.new
```

---


```ruby linenums=true
class FileAsJson
  def initialize(file)
    @file = file
  end

  def json
    result = {
      directory_id: file.directory.id,
      name: file.name,
      meta: { comment: file.comment },
    }

    result = plugins.apply_file_json(result, file)

    result
  end
end
```

---


```ruby
class PluginsRepository
  def apply_file_schema(schema)
    @plugins.each { |plugin| plugin.apply_file_schema(schema) }
  end

  def apply_file_json(result, file)
    result = result.clone

    @plugins.each { |plugin| result.mrge!(plugin.file_json(schema)) }

    result
  end

  def save_associations(file)
  def load_assosiations(file)
  def handle_file_created(file, dir)
  def handle_file_moved(file, dir_from, dir_to)
  # ...
end
```

---


```ruby
class FilesController < ApplicationController
  include HasPlugins

  params do
    required(:directory_id).filled(:uuid)
    required(:upload_id).filled(:uuid)
    required(:name).filled(:string)
    optional(:meta).hash do
      required(:comment).filled(:string)
    end

    plug("Schema") # -> Ceritifactes::FilesController::Schema
  end
end
```

---

```ruby

module HasPlugins
  def plug(name, params = {})
    params[:context] ||= self

    plugins.plug(name, params)
  end
end
```

---

```ruby
def plug(target, params)
  @plugs = {}

  value = yield if block_given?

  plugins.each do |plugin|
    name = [plugin.engine_name.camelize, namespace(params), target].join("::")
    @plugs[name] ||= name.safe_constantize

    next if @plugs[name].nil?
    return @plugs[name] if params[:const_only]

    value = if block_given?
      @plugs[name].new(params).() { value }
    else
      @plugs[name].new(params).()
    end
  end

  value
end
```

---

```ruby
class FilesRepository
  include HasPlugins

  def find(id)
    file = form_record(File.find(id))
    plug("FileAssociations", file:)

    file
  end
end
```

---


```ruby
class PluginsRepository
  def apply_file_schema(schema)
    @plugins.each { |plugin| plugin.apply_file_schema(schema) }
  end

  def apply_file_json(result, file)
    result = result.clone

    @plugins.each { |plugin| result.mrge!(plugin.file_json(schema)) }

    result
  end

  def save_associations(file)
  def load_assosiations(file)
  def handle_file_created(file, dir)
  def handle_file_moved(file, dir_from, dir_to)
  # ...
end
```

---


```plantuml
package DAM as System {
component Core as DAM {
}

component Certificates {
}

component CMS {
}

component VideoTranscoder {
}
}

Certificates --> DAM
CMS -> DAM
VideoTranscoder -left-> DAM

```

---

## База данных

---

## Автотесты

---

- spec
  - models
  - integration
  - plugins
    - certificates
      - models
      - integration
    - media_production

---

`rspec spec/plugins/certificates`

---

```
su-mac $ bundle exec rspec spec/plugins/certificates
Run options: exclude {:integration=>true}

Randomized with seed 20145
..........................................................
..........................................

Finished in 8.92 seconds (files took 1.49 seconds to load)
100 examples, 0 failures

Randomized with seed 20145
```

---

## Проблемы

---

## Будущее

---

## Спасибо

