# TODO

Основная мысль:

DAM - это эффективное решение с сильной командой, у которой есть видение масштабирования продукта, как по производительности, так и по сложности.

DAM

Что вы делаете?
Какую проблему вы решаете?
Чем вы отличаетесь?
Как это касается ваших слушателей?

https://why.esprezo.ru/like/steve-jobs



- сильная команда
- крутой продукт
- продать дам - привлечь стейкхолдеров

- плагин
- ТС - отдельный рут
- путь
    - ролевая модель
    - перенос 10Тб с google drive
- логирование
- kafkaesque интеграция
- цифры
    - скорость загрузки
    - число пользователей

---

# Upload

```sql
SELECT
  date_trunc('day', created_at)::date dt,
  sum(size) / 1000 / 1000 AS value
FROM
  blobs
GROUP BY
  dt
ORDER BY
  dt
```

---

# Files


```sql
SELECT
  date_trunc('day', created_at)::date dt,
  count(id) value
FROM
  files
GROUP BY
  dt
ORDER BY
  dt
```

---

# Active Users

```sql
WITH file_creators AS (
  SELECT
    created_at time,
    author_id AS user_id
  FROM
    files
),
directory_creators AS (
  SELECT
    created_at time,
    author_id AS user_id
  FROM
    directories
),
file_updaters AS (
  SELECT
    updated_at AS time,
    UUID (META ->> 'updater_id') AS user_id
  FROM
    FILES
  WHERE
    META ? 'updater_id'
),
directory_updaters AS (
  SELECT
    updated_at AS time,
    UUID (meta ->> 'updater_id') AS user_id
  FROM
    DIRECTORIES
  WHERE
    META ? 'updater_id'
)
SELECT
  date_trunc('day', time)::date dt,
  count(DISTINCT user_id) value
FROM (
  SELECT
    *
  FROM
    file_creators
  UNION
  SELECT
    *
  FROM
    directory_creators
  UNION
  SELECT
    *
  FROM
    file_updaters
  UNION
  SELECT
    *
  FROM
    directory_updaters) t1
GROUP BY
  dt

```

