# Контекст
2 из 8

---

![bg](img/warning.png)

<!-- header: Контекст 2 из 8 -->

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

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/fixtures">https://github.com/rom-rb/rom/blob/7fb82c/spec/fixtures</a>

---

![bg](img/warning.png)

```ruby
RSpec.shared_context 'changeset / database' do
  include_context 'changeset / database setup'

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
  end
end
```

<a class="link--source" href="https://github.com/rom-rb/rom/blob/7fb82c/spec/shared/rom/changeset/database.rb">https://github.com/rom-rb/rom/blob/7fb82c/spec/shared/rom/changeset/database.rb</a>


---

<style scoped>
.hljs-comment { color: red; background: yellow }
</style>

![bg](img/bg/rspec.png)

# `attr_reader`

```ruby
context 'when used in combination with the BisectDRbFormatter', :slow do
  include FormatterSupport

  attr_reader :server # <<<<<<<<<

  around do |ex|
    Bisect::Server.run do |the_server|
      @server = the_server
      ex.run
    end
  end

  def run_formatter_specs
    RSpec.configuration.drb_port = server.drb_port
    run_rspec_with_formatter('bisect-drb')
  end

  it 'receives suite results' do
    results = server.capture_run_results(['spec/rspec/core/resources/formatter_specs.rb']) do
    end
  end
end
```

<a class="link--source" href="https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/bisect/server_spec.rb">https://github.com/rspec/rspec-core/blob/1eeadc/spec/rspec/core/bisect/server_spec.rb</a>


---

<style scoped>
.hljs-comment { color: red; background: yellow }
</style>

![bg](img/bg/dry-rb.png)

# Перменные вне блоков

```ruby
RSpec.describe(Dry::Monads) do
  let(:m) { described_class }
  list = Dry::Monads::List # <<<<<<<<<<<<

  it "builds a list with List[]" do
    expect(instance.make_list).to eql(list[1, 2, 3])
  end
end
```

<a class="link--source" href="https://github.com/dry-rb/dry-monads/blob/704c1b/spec/integration/monads_spec.rb">https://github.com/dry-rb/dry-monads/blob/704c1b/spec/integration/monads_spec.rb</a>


---

![bg](img/bg/gitlab.png)

# let_it_be

```ruby
RSpec.describe Projects::BranchesByModeService, feature_category: :source_code_management do
  let_it_be(:user) { create(:user) }
  let_it_be(:project) { create(:project, :repository) }

  let(:finder) { described_class.new(project, params) }
  let(:params) { { mode: 'all' } }
end
```

<a class="link--source" href="https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/services/projects/branches_by_mode_service_spec.rb">https://github.com/gitlabhq/gitlabhq/blob/652dfd/spec/services/projects/branches_by_mode_service_spec.rb</a>

---

# TestProf

![](img/test-prof.png)

---

![bg](img/bg/vcr.png)

# `as_null_object` 1/2

```ruby
allow(config).to receive(:logger).and_return(double.as_null_object)
```

<a class="link--source" href="https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette/http_interaction_list_spec.rb">https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette/http_interaction_list_spec.rb</a>

---

# `as_null_object` 2/2

```ruby
logger = double.as_null_object

expect { logger.info }.not_to raise_error
expect(logger.foo.bar).to be_nil?
```

---

![bg](img/warning.png)

# Инкапсуляция

```ruby
describe 'clean_outdated_http_interactions' do
  before(:each) do
    subject.instance_variable_set(:@clean_outdated_http_interactions, true)
    subject.instance_variable_set(:@previously_recorded_interactions,
                                  subject.instance_variable_get(:@new_recorded_interactions))
    subject.instance_variable_set(:@new_recorded_interactions, [])
  end
end
```

<a class="link--source" href="https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette_spec.rb">https://github.com/vcr/vcr/blob/8f5636/spec/lib/vcr/cassette_spec.rb</a>

---


<!-- header: "" -->
