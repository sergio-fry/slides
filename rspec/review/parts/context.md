
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

rom-rb

---

```ruby

		it "shouldn't accept invalid return from fit_to_copy_get" do
			tm = Class.new(PG::TypeMapInRuby) do
				def fit_to_copy_get
					:invalid
				end
			end.new.freeze

			ce = PG::TextDecoder::CopyRow.new(type_map: tm).freeze
			expect{ ce.decode("5\t6\n") }.to raise_error(TypeError, /kind of Integer/)
		end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_map_in_ruby_spec.rb

---

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
