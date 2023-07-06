---
marp: true
---

# GraphQL Federation

---

# Subgraph A

```graphql
{
  damDirectory(id: UUID!): DamDirectory!
  damFile(id: UUID!): DamFile!
}
```

---

# Subgraph B

```graphql
{
  authUser(id: UUID!): AuthUser!
}
```

---

# Supergraph

```graphql
{
  damDirectory(id: UUID!): DamDirectory!
  damFile(id: UUID!): DamFile!
  authUser(id: UUID!): AuthUser!
}
```

---

# Why Prefix?

* **dam**File
* **dam**Directory
* **auth**User

---

# Namespace

---

# Queries

```graphql
{
  dam {
    directory(id: UUID!): DamDirectory!
    file(id: UUID!): DamFile!
  }
  auth {
    user(id: UUID!): AuthUser!
  }
}
```

---

# Mutations

```graphql
{
  dam {
    file {
      create(input: damFileCreateInput!): damFileCreatePayload!
      move(input: damFileMoveInput!): damFileMovePayload!
    }
  }
}
```

---

# Types

* DamFile
* DamDirectory
* AuthUser


---

# Paul Damnhors

![](https://avatars.githubusercontent.com/u/1946920)

---

# Links

* https://t.ly/_b5a GraphQL Best practices
* https://t.ly/AZHrp Apollo Federation Namespace
