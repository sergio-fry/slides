# Open Closed Principal

> software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification

SOLID

Преимущество от использования этого принципа состоит в том, что такой код легче адаптировать к новым требованиям. Изменение внутренней реализации добавляет риск сделать ошибку и нарушить целостность класса. 

Не будем спорить с самим принципом, а лучше посмотрим, как его можно применить в  ruby.


## Monkey Patching

Рассмотрим класс доступа к HTTP-ресурсу.

```ruby
class HTTPResource
  def initialize(url)
    @url = url
  end

  def body
    make_request
    @response.body
  end

  def code
    make_request
    @response.code
  end

  private

  def make_request
    @response = # make request
  end
end
```

А теперь нам потребовалось добавить повторную попытку, если код ответа 502. Так как у нас ruby, мы можем открыть класс и переопределить метод.

```ruby
class HTTPResource
  private

  def make_request
    @response = # make request

    if code == 502
      @response = # make request
    end
  end
end
```

Monkey patching имеет глобальные последствия для всех потребителей этого класса, так как мы вмешались в его внутреннее устройство. 

Проблема в том, что изначальный класс устроен так, что его сложно расширить корректно, то есть он не отвечает требованиям принципа open-closed.

## Наследование

```ruby
class HTTPResourceWithRetry < HTTPResource
  private

  def make_request
    super

    if code == 502
      super
    end
  end
end
```

Данные изменения будут действовать только для тех случаев, где мы явно используем HTTPResourceWithRetry, уже лучше.

А теперь предположим, что нам нужно научиться работать со сжатыми ресурсами.

```ruby
class UncompressedHTTPResource < HTTPResource
  def body
    uncompress super
  end
end
```

С одной стороны, вышло неплохо: мы изменили поведение без изменения начального класса. С другой, непонятно, как мы можем объединить логику retry и сжатия.


Кроме того, расширение через наследование не такое уж безобидное, если нам приходится переопределять методы родительского класса.

Добавим в начальный класс метод определения размера тела.

```ruby
class HTTPResource
  # ...

  def size
    body.size
  end

  # ...
end
```

Теперь вернёмся к примеру со сжатием.

```ruby
resource = UncompressedHTTPResource.new "https://example.com/page.gz"

resource.size 
```

С одной стороны, наш метод "автоматически" стал показывать размер распакованного документа, что может показаться удачей. Однако, мы потеряли возможность узнать размер исходного тела. Кроме этого, может сломаться функциональность, которая рассчитывала, что `.size` - это именно исходный размер тела. Например, сопоставление с Content-Length заголовком.

## Конфигурация

Часть проблем можно решить, если добавить в класс возможность конфигурирования.

```ruby
class HTTPResource
  def initialize(url, retry_codes: [502])
    @url = url
    @retry_codes = retry_codes
  end

  # ..

  private

  def make_request
    @response = # make request

    if code.in? @retry_codes
      @response = # make request
    end
  end
end
```

Теперь мы получили возможность 


## Dependency Injection

Предлагаю доработать наш класс, чтобы в нем появились "закладки" для будущих изменений.


```ruby
class HTTPResource
  def initialize(url, retry_strategy: ->(code, body, headers) { false })
    @url = url
    @retry_strategy = retry_strategy
  end

  def body
    make_request
    @body
  end

  def code
    make_request
    @code
  end

  private

  def make_request
    @body, @code, @headers = # make request

    while @retry_strategy.call(@code, @body, @headers)
      @body, @code, @headers = # make request
    end
  end
end
```

Тогда мы сможем переписать наш HTTPResourceWithRedirect таким образом:

```ruby
HTTPResource.new(
  "https://example.com/page",
  retry_strategy: ->(code, body, headers) {
    code.in?(502, 500)
  }
)
```
