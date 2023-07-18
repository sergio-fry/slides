---

marp: true
paginate: true

---

# DAM Arch

---

# Requirements

* 5 Tb
* + 2Tb/Year
* 1Gb per file
* 200 users


---

# MVP

---

# Ruby

---

# Storage

---

# Everything File or Dir

---

# Upload

1. create file placeholder
2. upload to s3
3. uploaded event

---

# S3 Structure. Natural

---

# S3 Structure

```text
2023/
  07/
    d9d3493e-9696-458d-8030-790245ef1be7
    047217d7-5b99-4d22-96f7-97a71fd1d545
    ...
  08/
    678a550d-9e11-46bc-820f-ebac29907342
    ...
```

---

# Versioning

---

# Move / Rename

---

# No Modification

---

# Automation

---

# WebDav

---

# Upload zip

---

# Download Dir Problem

---

# Recalculate Size

---

# Upload S3 Event

---

# TODO

- слайд про задачу на MVP - ретуширование
- Upload seqeunce
- S3 Structure. слайд вложенность s3 - storage - dam
-  перед слайдом структуры
  - s3 key value
  - s3 не директорий
- erd версионирование
- передвинуть no modification на до rename, versioning, move
- permissions
  - unix
  - groups

- сценарии
  - тригеры
  - действия
  - обязательность полей
  - условия для статусных переходов
  - контекстное меню


- режимы

- слайд os native - перед webdav

- Download file desposition
