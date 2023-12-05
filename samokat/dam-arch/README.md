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

# Архитектура DAM

---

<!-- footer:  https://bit.ly/418IZYt / @SergeiUdalov / DAM -->

# Требования

* 10Tb
* +2Tb / год
* размер файла ≤2Gb 
* 200 users

---

# Ruby

---

# Roadmap

* media production
* +MM
* automation
* редактирование inline
* ML

---

# Layers

* S3
* Storage
* Automation

---

# Все файл или папка

---

# Словарь

* актив
* тип актива
* вид актива
* сценарий
* метаданные
* см https://space.samokat.ru/x/iazp4Q

---

# S3

* key / value
* rename
* move
* copy

---

# Natural Structure

```bash
root
├── docs
│   ├── readme.md
│   └── rules.docx
└── photos
    ├── 001.jpeg
    └── retouched.psd
```

---

# S3 Structure

```bash
s3
└── 2023
    ├── 07
    │   ├── 047217d7-5b99-4d22-96f7-97a71fd1d545
    │   └── d9d3493e-9696-458d-8030-790245ef1be7
    └── 08
        ├── 678a550d-9e11-46bc-820f-ebac29907342
        └── d607e4f9-2758-4364-a6e1-a72965be3c5b
```

---

# Upload

```plantuml
actor Browser

Browser --> DAM: Create Upload
DAM --> Browser:  Presigned URL
Browser --> S3: Upload
Browser --> DAM: Create File
```

---

# Без модификаций

```bash
s3
└── 2023
    └── 12
        ├── 678a550d-9e11-46bc-820f-ebac29907342 # version 1
        └── d607e4f9-2758-4364-a6e1-a72965be3c5b # version 2
```


---

# Версионирование



---

# Вызовы

* производительность
* превью
* скачивание папки
* расчет размера папки
* система плагинов

---

# Плагин


* виды активов
* мета
* сценарии автоматизации
* тригеры и события
* действия контекстного меню
* режим работы

---

# Native Client

---

# Итоги

* все файлы и папки
* меньше Ruby
* избегать update
* хранилище + плагины

---

# Спасибо!
