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

## Кто я?

---

## Микросервисы

---

## О проекте

---

## Результаты

- 10_000_000 файлов
- +30Гб/день
- 1.5 года в прод
- 3 месяца на MVP

---

## О чем речь?

1. DDD
2. Monolith First
3. Плагины

---

## Проблемы разработки DAM

- Группы пользователей
- Много видов активов
- Разные интерфейсы
- Разные валидации, механики автоматизации

---

## Архитектура Продукта

```plantuml

skinparam rectangle {
  
  backgroundColor<<DAM API>> White
}

rectangle "Ruby" as API <<DAM API>>

rectangle "nodejs" as Apollo <<Apollo Federation>>
rectangle Frontend
queue "Elixir" as ws <<Web Sockets>>
queue "Kafka" as ES <<Event Streaming>>
database PostgreSQL as db <<Database>>
database Redis as cache <<Cache>>
cloud "S3" as storage
rectangle "Ruby" as transcoder <<Video Transcoder>>
rectangle "Elixir" as events <<Event Relay>>
actor user
rectangle "Service A" as servce_a


user -> Frontend
Frontend -> ws: sub

Frontend -> Apollo
Apollo -> API 
API --> cache
API --> db

API -> storage
API --> transcoder
API --> ws: pub
events ..> db: outbox
events -> ES: pub

ES <.. servce_a: sub

```

---

## Domain Driven Design

- Domain Model
- **Ubiquitous Language**
- **Bounded Context**

---

## Принципы

- Файлы и папки
- Разделение ядра и контекстов
- Feature toggle

---

## Словарь

---

## Архитектура приложения

```plantuml
mutation --> interactor
interactor --> repository
interactor --> model

repository --> database
repository --> s3
```

---

## Что должно стать плагином?

---

## Plugin

---

```plantuml

package "Core" {
  class File
  class CreateFile
}

package "Media Production" {
  class PublishImage
  class Image
}


PublishImage .> Image
PublishImage ..> CreateFile
Image --|> File
CreateFile .> File

```

---

## Размещение логики

- app
  - domain
  - interactors
- plugins
  - certificates
    - app
      - domain
      - interactors
  - media_production
  - cms
  - video_transcoder

---

## Вызов из ядра

---

```ruby
class File
  include HasPlugins

  def rename(new_value)
    plug("Rename", new_value: new_value)

    @name = name
  end
end
```

---

## plug

- "{Plugin}::File::Rename"
- ищет в каждом плагине
- последовательно вызывает

---

```ruby
module MediaProduction
  module File
    class Rename
      def initialize(params = {})
        @context = params[:context] # объект, который вызвал плагин
        @new_value = params[:new_value]
      end

      def call
        # действие
      end
    end
  end
end
```

---

## API

```ruby
module Api
  module Directories
    class CreateController < ::Api::BaseJsonController
      include HasPlugins
        schema do
          required(:parent_id).filled(::DamTypes::Suid)
          required(:name).filled(:string)
          plug("Schema", schema: self)
        end
      end
    end
  end
end
```

---

```ruby
module VideoTranscoder
  module Directories
    module CreateController
      class Schema
        def initialize(params)
          @schema = params[:schema]
        end

        def call
          @schema.instance_eval do
            optional(:video_transcoder_comment).filled(:string)
          end
        end
      end
    end
  end
end
```

---

## База данных

- префикс
- отдельные таблицы
- связи

---

## Проектирование БД

---

```dbml
Table directories {
    id uuid [primary key]
    name varchar
    parent_id uuid
}

Ref: directories.parent_id > directories.id

Table files {
    id uuid [primary key]
    name varchar
    directory_id uuid
}

Ref: files.directory_id > directories.id

Table mp_files {
    id integer [primary key]
    barcode varchar
    status enum
    file_id uuid
}

Ref: mp_files.file_id > files.id
```

---

## Расширение Repo

```ruby
module Repositories
  class Files
    include HasPlugins

    def save(file)
      db[:files].where(id: file.id).update(name: file.name)

      plug("Save", file:)
    end
  end
end

```

---

```ruby

module MediaProduction
  module Repositories
    module Files
      class Save
        def initialize(params)
          @file = params[:file]
        end

        def call
          db[:mp_file]
            .where(file_id: @file.id)
            .update(barcode: file.meta.media_production.barcode)
        end
      end
    end
  end
end
```

---

## Что еще?

- contructor
- serializer
- graphql
- kafka events

---

## Автотесты

---

- spec
  - domain
  - integration
  - plugins
    - certificates
      - domain
      - integration
    - media_production
    - cms
    - video_transcoder
    - ...

---

## Дальнейшее развитие

---

## Кастомные интерфейсы

---

## Микросервисы

---

## Итоги
