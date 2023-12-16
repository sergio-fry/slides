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


  h1, p, ul li { color: black; }
  pre { border: 0px; background: white; }

  footer { color: #bbb }
  footer a { color: #bbb }

</style>

<!-- _paginate: skip -->


# Sequel Pull Request

---

<!-- footer: seqeul pull request › @SergeiUdalov -->

https://github.com/sergio-fry

---

# Sequel

https://sequel.jeremyevans.net

---

https://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html

---

```ruby
task migrate: :environment do
  Sequel::Migrator.run(DB, BootConfig.config.migrations_dir)
end
```

---

# Rollback

---

# IntegerMigrator

```ruby
Sequel::Migrator.run(DB, BootConfig.config.migrations_dir, relative: -1)
```

---

# TimestampMigrator

not implemented

---

# Let's Code!

---

https://github.com/jeremyevans/sequel/blob/aecf74102692f4792f6925e6ecc7c49e3663d1cd/lib/sequel/extensions/migration.rb#L425

---

# RollbackTimestamp

---

```ruby
module Sequel
  class RollbackTimestamp
    def initialize(db, directory)
      @db = db
      @directory = directory
    end

    def can_rollback?
      !migrator.applied_migrations.empty?
    end

    def previous_version
      return 0 if migrator.applied_migrations.size == 1

      previous_migration = migrator.applied_migrations[-2]
      previous_migration.nil? ? 0 : migrator.send(:migration_version_from_file, previous_migration)
    end

    def run
      raise "Nothing to rollback" unless can_rollback?

      migrator(target: previous_version).run
    end

    def migrator(opts = {}) = Sequel::TimestampMigrator.new(@db, @directory, opts)
  end
end
```

---

# Test PR

https://github.com/jeremyevans/sequel/pull/2102

---

https://github.com/jeremyevans/sequel/blob/aecf74102692f4792f6925e6ecc7c49e3663d1cd/lib/sequel/extensions/migration.rb#L525


