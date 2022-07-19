---
paginate: true
class: lead
marp: false
---
<style>
  {font-family: Monaco}
  section {
    /* background: #f2f2f2; */
  }
  h1,body,li,p { color: black; }

  h1 {
    text-decoration: underline;
    text-decoration-color: #FF5028;
    text-underline-offset: 0.3em;
    text-decoration-thickness: 0.1em;
    padding-bottom: 0.3em;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    max-height: 70%;
    max-width: 100%;
  }
</style>
<!--
_paginate: false
_class: lead
-->


# Ruby Extensions



# Extentions


* monkey patching
* dependecy injection
* ActiveRecord (callbacks)
* rack
* faraday
* ActiveJob (adapter, hooks)
* rspec (include)
* devise
* redmine
* jekyll
* dry-types
* huginn
* logger
* sidekiq


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

