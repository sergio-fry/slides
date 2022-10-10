# Ruby Extensions

---
# Open–closed principle
> software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification

SOLID

<!-- The benefit of writing open-closed code is that it makes it easier to handle new requirements. Modifying the internals of a class/module is more difficult and error prone than creating a new class/module to extend functionality. -->

---


# TODO

[ ] dry-types
[ ] huginn
[ ] nokogiri


---

# Rails Engine

## Redmine

* новые модели, контроллеры, view
* Rails callbacks
* Redmine hooks

Можно переопределить view, но не дополнить. Есть возможножсть встроить свой экран в настйроки (админка) через partial.

Кстати, интересным сделано хранение настроек плагинов через единый класс Settings. А для управления плагином есть класс Plugin.

А вот как происходит расширение пользователя:

```ruby
module RedmineWorkload
  module Extensions
    module UserPatch
      def self.prepended(base)
        base.prepend(InstanceMethods)
        base.class_eval do
          has_one :wl_user_data, inverse_of: :user
          has_many :wl_user_vacations, inverse_of: :user
          delegate :main_group, to: :wl_user_data, allow_nil: true
        end
      end

      module InstanceMethods
        ##
        # Prefer to use main_group_id over User#wl_user_data.main_group since
        # the latter may lead to
        # NoMethodError Exception: undefined method `main_group' for nil:NilClass
        # when no data set for wl_user_data exists. In contrast, the delegation
        # of main_group, as used below, will handle this case.
        #
        def main_group_id
          main_group
        end
      end
    end
  end
end

# Apply patch
Rails.configuration.to_prepare do
  unless User.included_modules.include?(RedmineWorkload::Extensions::UserPatch)
    User.prepend RedmineWorkload::Extensions::UserPatch
  end
end

```



---

# ActiveRecord

* relations
* validations
* STI
* configuration
* callbacks
* inheritance

---

# Enumerable

```ruby
class RemoteItems
  include Enumerable

  def each
    CSV.parse(open('http://example.com/items.csv')).each do |item|
      yield item
    end
  end
end
```


---

# Devise

```ruby
devise :database_authenticatable, :registerable, :confirmable, :uid
```

```ruby
Devise.add_module :uid, :model => "devise_uid/model"
```

```ruby
module Devise
  module Models
    module Uid
      extend ActiveSupport::Concern

      included do
        before_save :generate_uid
      end

      module ClassMethods
        def uid
          loop do
            token = Devise.friendly_token
            break token unless to_adapter.find_first({ :uid => token })
          end
        end
      end

      private

      def generate_uid
        self.uid = self.class.uid if self.uid.nil?
      end
    end
  end
end
```

## Warden

### Callbacks

With all callbacks, you can add as many as you like, and they will be executed in the order they were declared. If you want to prepend a callback, you should prefix each callback name with "prepend_", e.g. prepend_before_failure, prepend_before_logout and so on, and pass the same arguments described below.

* after_set_user
* after_authentication
* after_fetch
* before_failure
* after_failed_fetch
* before_logout
* on_request

```ruby
Warden::Manager.after_set_user do |user, auth, opts|
  unless user.active?
    auth.logout
    throw(:warden, :message => "User not active")
  end
end
```

### Strategies

```ruby
use Warden::Manager do |manager|
  manager.default_strategies :password, :basic
  manager.failure_app = BadAuthenticationEndsUpHere
end
```

```ruby
Warden::Strategies.add(:password) do
  def valid?
    params['username'] || params['password']
  end

  def authenticate!
    u = User.authenticate(params['username'], params['password'])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end
```

```ruby
def add(label, strategy = nil, &block)
  strategy ||= Class.new(Warden::Strategies::Base)
  strategy.class_eval(&block) if block_given?

  unless strategy.method_defined?(:authenticate!)
    raise NoMethodError, "authenticate! is not declared in the #{label.inspect} strategy"
  end

  base = Warden::Strategies::Base
  unless strategy.ancestors.include?(base)
    raise "#{label.inspect} is not a #{base}"
  end

  _strategies[label] = strategy
end
```

### Failure App

```ruby
manager.failure_app = Proc.new { |_env|
  ['401', {'Content-Type' => 'application/json'}, { error: 'Unauthorized', code: 401 }]
}
```

Devise:

```ruby
class CustomFailureApp < Devise::FailureApp
  def redirect
    store_location!
    message = warden.message || warden_options[:message]
    if message == :timeout     
      redirect_to attempted_path
    else 
      super
    end
  end
end
```


# Jekyll

Не дает возможности изменить поведение внутри core, но дает возможность добавить новые: tags, generators, convertors, filters, hooks


## Liquid Tag
```ruby
class YouTubeEmbed < Liquid::Tag
  def render(conext)
    # ...
  end
end

Liquid::Template.register_tag "youtube", YouTubeEmbed

```

## Converter

```ruby
module Jekyll
  class UpcaseConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /^\.upcase$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      content.upcase
    end
  end
end
```

```ruby
    def setup
      ensure_not_in_dest

      plugin_manager.conscientious_require

      self.converters = instantiate_subclasses(Jekyll::Converter)
      self.generators = instantiate_subclasses(Jekyll::Generator)
    end
```


## Hooks

```ruby
Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  Jekyll::Emoji.emojify(doc) if Jekyll::Emoji.emojiable?(doc)
end


def self.insert_hook(owner, event, priority, &block)
  @hook_priority[block] = [-priority, @hook_priority.size]
  @registry[owner][event] << block
end

    # initial empty hooks
    @registry = {
      :site      => {
        :after_init  => [],
        :after_reset => [],
        :post_read   => [],
        :pre_render  => [],
        :post_render => [],
        :post_write  => [],
      },
      :pages     => {
        :post_init    => [],
        :pre_render   => [],
        :post_convert => [],
        :post_render  => [],
        :post_write   => [],
      },



Jekyll::Hooks.trigger :site, :after_init, self
#...

```

# Logger


```ruby
logger = Logger.new(logdev, level: Logger::INFO)
logger.level = Logger::DEBUG
logger.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
end
```

```ruby
@logdev.write(
  format_message(format_severity(severity), Time.now, progname, message)
)
```

```ruby
Logger.new(BufferedDevice.new(logdev))
```


---

# Rack

https://github.com/rack/rack/blob/a7747ec32e9971649257e838b0b49b9588945107/lib/rack/builder.rb#L148    
```ruby
def use(middleware, *args, &block)
  if @map
    mapping, @map = @map, nil
    @use << proc { |app| generate_map(app, mapping) }
  end
  @use << proc { |app| middleware.new(app, *args, &block) }
end
```


https://github.com/rack/rack/blob/a7747ec32e9971649257e838b0b49b9588945107/lib/rack/builder.rb#L226
```ruby
def to_app
  app = @map ? generate_map(@run, @map) : @run
  fail "missing run or map statement" unless app
  app.freeze if @freeze_app
  app = @use.reverse.inject(app) { |a, e| e[a].tap { |x| x.freeze if @freeze_app } }
  @warmup.call(app) if @warmup
  app
end
```

# Faraday

## Adapter

```ruby
# You can use @connection_options and @config_block in your adapter code
class FlorpHttp < ::Faraday::Adapter
  dependency do
    require 'florp_http'
  end
  def call(env)
    # `connection` internally calls `build_connection` and yields the result
    connection do |conn|
      # perform the request using configured `conn`
    end
  end

  def build_connection(env)
    conn = FlorpHttp::Client.new(pool_size: @connection_options[:pool_size] || 10)
    @config_block&.call(conn)
    conn
  end
end


Faraday::Adapter.register_middleware(florp_http: FlorpHttp)

ruby2_keywords def adapter(klass = NO_ARGUMENT, *args, &block)
  return @adapter if klass == NO_ARGUMENT || klass.nil?

  klass = Faraday::Adapter.lookup_middleware(klass) if klass.is_a?(Symbol)
  @adapter = self.class::Handler.new(klass, *args, &block)
end

```


Еще можно передать 
```ruby
conn = Faraday.new do |f|
  f.adapter FlorpHttp
end
```


```ruby
conn = Faraday.new do |f|
  f.use Faraday::Request::UrlEncoded
  f.use Faraday::Response::Logger
  f.use Faraday::Adapter::NetHttp
end
```

```ruby
ruby2_keywords def use(klass, *args, &block)
  if klass.is_a? Symbol
    use_symbol(Faraday::Middleware, klass, *args, &block)
  else
    raise_if_locked
    raise_if_adapter(klass)
    @handlers << self.class::Handler.new(klass, *args, &block)
  end
end

def to_app
  # last added handler is the deepest and thus closest to the inner app
  # adapter is always the last one
  @handlers.reverse.inject(@adapter.build) do |app, handler|
    handler.build(app)
  end
end
```

## ActiveJob

```ruby
class InlineAdapter
  def enqueue(job) # :nodoc:
    Base.execute(job.serialize)
  end

  def enqueue_at(*) # :nodoc:
    raise NotImplementedError, "Use a queueing backend to enqueue jobs in the future. Read more at https://guides.rubyonrails.org/active_job_basics.html"
  end
end
```

```ruby
def perform_now(...)
  job_or_instantiate(...).perform_now
end

def execute(job_data) # :nodoc:
  ActiveJob::Callbacks.run_callbacks(:execute) do
    job = deserialize(job_data)
    job.perform_now
  end
end
```


```ruby
def enqueue(options = {})
  set(options)
  self.successfully_enqueued = false

  run_callbacks :enqueue do
    if scheduled_at
      queue_adapter.enqueue_at self, scheduled_at
    else
      queue_adapter.enqueue self
    end

    self.successfully_enqueued = true
  rescue EnqueueError => e
    self.enqueue_error = e
  end

  if successfully_enqueued?
    self
  else
    false
  end
end
```

## ActiveSupport Load Hooks

```ruby
class Base
  include Core
  include QueueAdapter
  include QueueName
  include QueuePriority
  include Enqueuing
  include Execution
  include Callbacks
  include Exceptions
  include Instrumentation
  include Logging
  include Timezones
  include Translation

  ActiveSupport.run_load_hooks(:active_job, self)
end
```

```ruby
def on_load(name, options = {}, &block)
  @loaded[name].each do |base|
    execute_hook(name, base, options, block)
  end

  @load_hooks[name] << [block, options]
end

def run_load_hooks(name, base = Object)
  @loaded[name] << base
  @load_hooks[name].each do |hook, options|
    execute_hook(name, base, options, hook)
  end
end
```


# Sidekiq

https://github.com/getsentry/sentry-ruby/blob/master/sentry-sidekiq/lib/sentry-sidekiq.rb

```ruby
Sidekiq.configure_server do |config|
  config.error_handlers << Sentry::Sidekiq::ErrorHandler.new
  config.server_middleware do |chain|
    chain.add Sentry::Sidekiq::SentryContextServerMiddleware
  end
  config.client_middleware do |chain|
    chain.add Sentry::Sidekiq::SentryContextClientMiddleware
  end
end

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sentry::Sidekiq::SentryContextClientMiddleware
  end
end
```

# Technics

  * inheritance
  * settings, descision maker
  * rack
  * event
  * class autoload (guess by name, list)
  * dependency injection

# Anti-patterns

 * monkey patching
 * method overriding 
 * global config without local
