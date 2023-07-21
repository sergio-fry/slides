---

marp: true
paginate: true

---

<style>
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-width: 90%;
    max-height: 90%;
  }
</style>

# DAM Architecture

---

<!-- footer: DAM Architecture -->

# Requirements

* 5 Tb
* 2Tb/Year
* 1Gb per file
* 200 users

---

# Ruby

---

# Roadmap

1. photos
1. videos
1. documents
1. ?

---

# Layers

* S3
* Storage
* Automation

---

# Asset is File or Dir

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

# DB

```plantuml
entity Blob {
  --
  * s3_key
  * status
  * size
  * file_id
}

entity File {
  --
  * name
}

Blob }|-- File
```

---

# Upload

```plantuml
actor Browser

Browser --> DAM: Create file
DAM --> Browser:  Presigned URL
Browser --> S3: Upload
Browser --> DAM: File Updated Event!
```

---

# No Modification

---

# Versioning

---

# Automation

* action
* trigger
* required fields
* events


---

# Download Dir Problem

---

# Directory Size

---

# Native Client

---

# Modes


<!--

# TODO

- сценарии
  - тригеры
  - действия
  - обязательность полей
  - условия для статусных переходов
  - контекстное меню

      -->
