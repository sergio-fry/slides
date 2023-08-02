# TODO

* краткость, читаемость, декларативность
* тесты - это тоже код и к нему применимы все критерии качества, что и к остальному коду
    * отличия кода и тестов? в них них поведения
* Даже, если тесты для кода не пишутся, проектировать код следует так, чтобы его можно было протестировать при необходимости.
* Arrange Act Assert
    * expect to receive
* предположения
    * expected_result (можно ли проверить рубокопом)
    * не требовать лишнего
    * порядок важен или нет?
    * в отельн
* тест должен общаться с кодом на том же уровне абстракции, использовать API кода
* oneliners, less comments, let
* контекст описан в самом тесте, поэтому не fixtures, faker
* dummy app (antipattern)
    * так же, как fixtures
* subject as action
* структура файлов
    * support (testing module)
    * _spec
    * тестирование отдельных классов - это зависимость. нужны интеграционные тесты, чтобы проверять поведение (при рефакторинге полезно)
* fake boundaries
* describe
    * subject
    * subject name
* context
    * before
    * let
* DRY
    * выделить примеры
    * причина важна
    * Сначала сделать корректный тест и код, а потом dry 
* Если нет времени писать много тестов, то какие нужно писать в первую очередь?
    * на пирамиде подсветить, какие варианты у нас есть
    * много юнит тестов?
    * интеграционные важнее
    * упомянуть пирамиду до перехода к этому тезису и делать демонстрацию на ней
    * BDD - тестировать то, что важно для stakeholders
* Start writing dirty tests, with long descriptions, without contexts, making multiple expectations for test, but then refactor and next time follow the right way.
* какие копы можно было бы сделать?
* из сообщения об ошибке должно быть понятно, что не так. говорящие ошибки, контекст
* describe / context aliaeses
    * scenarios

* brackground
* double
    * class_double antipattern
    * stub(new)
    * stub chaining antipattern
    * когда, для чего
        * external dependencies
        * nonderterminism
        * dependency not implemented yet
        * no state
        * Тестируем слой в изоляции. Код может использовать классы тролле слоя
        * Можно и совсем юнит 
* Хрупкость из-за большой связанности тестов и кода
    * тестировать поведение, а не техническую реализацию
    * то, что важно
    * unit-тесты мешают при рефакторинге
* замена уродливых выражений на свои matchers
* удобные сообщения об ошибках
* expected to be_, have_
* expect instance_of to receive antipattern
* меньше ветвлений логики в acceptance/integration тестах. веротяно, тут можно про пирамиду
* Группировка тестов по доменам
* Очистка состояния
    * До или после?
    * Сам тест лучше всех знает, где намусорил , потому и убирать ему
* Support
    * Testing module
* Тест до кода


- bdd 
- сложные match include_hash ,,, чтобы не воспроизводить полную структуру, а только значимое (composable matchers)

- when_first_matching_example_defined ? что это
- RSpec rubocop
- читаемая ошибка - сообщение
    - .inspect для читаемости объекта в ошибках
