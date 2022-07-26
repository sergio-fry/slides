# Open Closed Principal

> software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification

SOLID

Преимущество от использования этого принципа состоит в том, что такой код легче адаптировать к новым требованиям. Изменение внутренней реализации добавляет риск сделать ошибку и нарушить целостность класса. 

Не будем спорить с самим принципом, а лучше посмотрим, как его можно применить в  ruby.


## Monkey Patching

```ruby
class HTTPResource
  def initialize(url)
    @url = url
  end

  def body
    # make request
  end
end
```

А теперь нам потребовалось добавить добавить следование переадресации, если код 30x

```ruby
class HTTPResource
  def body
    # make request
  
    while code.start_with("30")
      # make request
    end
  end
end
```

Monkey patching имеет глобальные последствия для всех потребителей этого класса, так как мы вмешались в его внутреннее устройство.

Проблема в том, что изначальный класс был устроен так, что его сложно было расширить корректно, то есть он не отвечал требованиям принципа open-closed.

Немного изменим наш класс

## Наследование

```ruby
class HTTPResource
  def initialize(url)
    @url = url
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
    @body, @code = # make request
  end
end
```

А теперь добавим редирект

```ruby
class HTTPResourceWithRedirect < HTTPResource
  private

  def make_request
    super

    while @code.start_with("30")
      super
    end
  end
end
```

Данные изменения будут действовать только для тех случаев, где мы явно используем HTTPResourceWithRedirect.

Теперь предположим, что нам нужно научиться работать со сжатыми ресурсами.

```ruby
class UncompressedHTTPResource < HTTPResource
  def body
    uncompress super
  end
end
```

С одной стороны, вышло неплохо: мы изменили поведение без изменения начального класса. С другой, непонятно, как мы можем объединить логику переадресации и сжатия.


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


