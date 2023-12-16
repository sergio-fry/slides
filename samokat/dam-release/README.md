---

marp: true
paginate: true

---

<style>
  img {
    display: block;
    max-height: 100%;
    max-width: 80%;
  }

  img[alt="uml diagram"] {
      margin-left: auto;
      margin-right: auto;
      max-width: 90%;
      max-height: 90%;
  }


  h1, p, ul li { color: black; }
  pre { border: 0px; background: white; }

  footer { color: #bbb }
  footer a { color: #bbb }


</style>

# DAM 1.0

---

<!-- footer:  https://bit.ly/418IZYt / @SergeiUdalov / DAM -->


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
  date_trunc('day', created_at)
  date,
  sum(size) / 1000 / 1000 AS size
FROM
  blobs
GROUP BY
  date
ORDER BY
  date
```

---

# Files


```sql
SELECT
  date_trunc('day', created_at) time,
  count(id) count
FROM
  files
GROUP BY
  time
ORDER BY
  time
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
  date_trunc('day', time) time1,
  count(DISTINCT user_id)
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
  time1

```

---

# Итоги

---

# Спасибо!
