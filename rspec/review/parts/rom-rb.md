```ruby

# TODO: each spec file should require its dependencies. Maybe we'll get there one day
require "rom"
require "rom/sql"
require "rom/memory"
require "rom/repository"
require "rom/changeset"
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb

```ruby

module Test
  def self.remove_constants
    constants.each(&method(:remove_const))
  end
end

  config.after do
    gateway.disconnect if respond_to?(:gateway) && gateway.respond_to?(:disconnect)
    Test.remove_constants
  end
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb


```ruby

  before do
    configuration.relation(:users)
    configuration.relation(:tasks)

    class Test::CreateUser < ROM::Commands::Create[:memory]
      config.component.id = :create
      config.component.namespace = :users
      config.component.relation = :users
      config.result = :one
    end
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/suite/rom/commands/create_spec.rb


```ruby

  config.define_derived_metadata file_path: %r{/suite/} do |metadata|
    metadata[:group] = metadata[:file_path]
      .split("/")
      .then { |parts| parts[parts.index("suite") + 1] }
      .to_sym
  end

  %i[rom compat].each do |group|
    config.when_first_matching_example_defined group: group do
      require_relative "support/#{group}"
    end
  end
```




https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/spec_helper.rb



```
▾ fixtures/
  ▾ app/persistence/
    ▸ commands/
    ▸ mappers/
    ▸ my_commands/
    ▸ my_mappers/
    ▸ my_relations/
    ▸ relations/
  ▾ auto_loading/
    ▾ app/
      ▸ commands/users/
      ▸ mappers/
      ▸ relations/
    ▸ persistence/
```


```ruby

RSpec.shared_context "changeset / database setup" do
  include_context "changeset / db_uri"

```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/shared/rom/changeset/database.rb

```ruby
RSpec.shared_context "changeset / database" do
```


```ruby
RSpec.shared_context "changeset / database" do
  include_context "changeset / database setup"

  before do
    %i[tags tasks books posts_labels posts users labels
       reactions messages].each { |table| conn.drop_table?(table) }

    conn.create_table :users do
      primary_key :id
      column :name, String
    end

    conn.create_table :books do
      primary_key :id
      foreign_key :author_id, :users, on_delete: :cascade
      column :title, String
      column :created_at, Time
      column :updated_at, Time
    end
```

https://github.com/rom-rb/rom/blob/7fb82cf7ffa86805d9c5499a4ecc64d5d3c20f14/spec/shared/rom/changeset/database.rb

```ruby

RSpec.describe ROM::SQL::Associations::ManyToMany, helpers: true do

```
https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/integration/associations/many_to_many_spec.rb

```ruby
  config.include(Helpers, helpers: true)
```

https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb

```ruby
  Dir[root.join("shared/**/*.rb")].sort.each { |f| require f }
  Dir[root.join("support/**/*.rb")].sort.each { |f| require f }
```

https://github.com/rom-rb/rom-sql/blob/beb1154e13e29087e514c0f143fd1bf0b5185fcf/spec/spec_helper.rb
