# TODO

- Метод с параметрами в expectation
- Subject стоит использовать в коротких блоках
- Избегать большой вложенности контекстов
- Разделять тесты класса на несколько файлов
- Subject с именем
- Проблема, когда сложные stubs повторяются для проверки expectation
- Checklist примеры краткие
- It should, it is expected to
- Marchers: have attributes, high order, eq , be_, 

* слайд про компанию после слайде обо мне (Анна)
* минимальность контекста
* изучить все keywords rspec

* посмотреть тесты, которые генерирует rails
* посмотреть доклады по RSpec
- Составить пример для рефакторинга после доклада. 
- All the little things talk by sandi Metz
- The magic tricks of testing sandi Metz


---

# Archive

* Группировка тестов по доменам
* Support 
  * Testing module


- RSpec rubocop


* какие копы можно было бы сделать? 
  * не использовать expected_result (можно ли проверить рубокопом)
* DRY 
  * выделить примеры
  * причина важна
* структура файлов 
  * support (testing module)
  * \_spec
* Очистка состояния после выполнения
* .inspect для читаемости объекта в ошибках

## Остальное

* Если нет времени писать много тестов, то какие нужно писать в первую очередь? 
  * на пирамиде подсветить, какие варианты у нас есть
  * интеграционные важнее
  * упомянуть пирамиду до перехода к этому тезису и делать демонстрацию на ней
  * BDD - тестировать то, что важно для stakeholders
* меньше ветвлений логики в acceptance/integration тестах. веротяно, тут можно про пирамиду
* Сначала сделать корректный тест и код, а потом рефайторинг (workflow)
* Start writing dirty tests, with long descriptions, without contexts, making multiple expectations for test, but then refactor and next time follow the right way.
* unit-тесты мешают при рефакторинге, интеграционные - помогают
