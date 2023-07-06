---
marp: true
paginate: true
---

# GraphQL Federation Namespace


---
<!-- footer: GraphQL Federation Namespace -->
<!-- header: As Is -->

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

- **dam**File
- **dam**Directory
- **auth**User

---
<!-- header: "" -->

# Namespace

<!-- Appolo Federation does not support namespaces -->

---
<!-- header: "Namespace" -->

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

- DamFile
- DamDirectory
- AuthUser

<!-- Can't fix -->

---

# Paul Damnhors

![](https://avatars.githubusercontent.com/u/1946920)

graphql-rules.com

---

# Links

- https://graphql-rules.com GraphQL Rules by Paul Damnhorns
- https://t.ly/AZHrp Apollo Federation Namespace
