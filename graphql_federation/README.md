---
marp: true
paginate: true
---

# GraphQL Federation Namespace


---
<!-- footer: GraphQL Federation Namespace -->

<!-- _header: As Is -->

# Supergraph

```graphql
{
  damDirectory(id: UUID!): DamDirectory!
  damFile(id: UUID!): DamFile!
  authUser(id: UUID!): AuthUser!
  cmsCategory(id: UUID!): CmsCategory!
  cmsFeature(id: UUID!): CmsFeature!
  cmsStory(id: UUID!): CmsStory!
}
```

---

<!-- _header: As Is -->

# Why Prefix?

- **dam**File
- **dam**Directory
- **auth**User

---

# Namespace

<!-- Appolo Federation does not support namespaces -->

---
<!-- _header: Namespace -->

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
<!-- _header: Namespace -->

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
