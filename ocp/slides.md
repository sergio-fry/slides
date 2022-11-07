---

paginate: true
class: lead
marp: true
---
<style>
  section {
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
    max-width: 90%;
  }
</style>
<!--
_paginate: false
_class: lead
-->


# Open-Closed Principle in Ruby

Sergei O. Udalov, Balance Platform

---

![](img/balance-platform.svg)

---
<!-- footer: OCP in Ruby, Sergei O. Udalov, Balance Platform -->

# SOLID

1. Single-responsibility principl
2. **Open–closed principle**
3. Liskov substitution principle
4. Interface segregation principle
5. Dependency inversion principle

---

# Open-Closed Principal

> You should be able to extend the behavior of a system without having to modify that system

Robert C. Marting

---

# Plugin System

> Plugin systems are the ultimate consummation, the apotheosis, of the Open-Closed Principle

Robert C. Martin

---

# Intro

---
<!-- header: "Intro" -->

# Monolith gem

```plantuml
package Application {
	package "core.gem" {
	  class Entity {
	  }
	  class Strategy {
	  }
	  class ABAC {
	  }
	  class Search {
	  }
	  class Versioning {
	  }
	  class RabbitMQ {
	  }
	}
}
```

---

# Pluggable

```plantuml
package Application {
  package "core.gem" {
    class Entity {
    }
    class Strategy {
    }
  }

  package "core-search.gem" {
    class Search {
    }
  }

  package "core-audited.gem" {
    class Versioning {
    }
  }

  package "core-rabbitmq.gem" {
    class RabbitMQ {
    }
  }

  class ABAC {
  }
}


"core-audited.gem" --> "core.gem"
"core-rabbitmq.gem" --> "core.gem"
"core-search.gem" --> "core.gem"
```

---

# But how?

---
<!-- header: "" -->

# In the Wild

- Enumerable
- Logger
- Redmine
- Jekyll
- ActiveJob
- Faraday
- Rack
- Warden

---

# Enumerable

---
<!-- header: Enumerable -->

```ruby
class RemoteItems
  include Enumerable

  def initialize(source)
    @source = source
  end

  def each
    CSV.parse(open(@source)).each do |item|
      yield item
    end
  end
end

items = RemoteItems.new 'http://example.com/items.csv'
items.count
items.any? { .. }
items.detect? { .. }
```

---
<!-- header: "" -->

# Logger

- level
- device
- formatter

---
<!-- header: Logger -->

# Log Level

```ruby
logger = Logger.new(STDOUT, level: Logger::INFO)
logger.level = Logger::WARN
```

---

# Device

```ruby
logger = Logger.new(BufferedDevice.new(STDOUT))
```
---

# Fromatter

```ruby
logger = Logger.new(STDOUT)
logger.formatter = proc do |severity, datetime, progname, msg|
  { dt: datetime, message: msg }.to_json
end
```

---

```ruby
def add(severity, message = nil, progname = nil)
  # ..
  @logdev.write(
    format_message(format_severity(severity), Time.now, progname, message))
  true
end

def format_message(severity, datetime, progname, msg)
  (@formatter || @default_formatter).call(severity, datetime, progname, msg)
end
```

---

# Inheritance

```ruby
class JSONLogger < Logger
  def format_message(severity, datetime, progname, msg)
    { dt: datetime, message: msg }.to_json
  end
end
```

---
<!-- header: "" -->

# Redmine (Rails Engine)

- controllers
- views
- models
- ...


---
<!-- header: Redmine -->

# Extend User

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

# Admin Menu

```ruby
<% @plugins.each do |plugin| %>
  <tr id="plugin-<%= plugin.id %>">
  <td class="name"><span class="name"><%= plugin.name %></span>
      <%= content_tag('span', plugin.description, :class => 'description') unless plugin.description.blank? %>
      <%= content_tag('span', link_to(plugin.url, plugin.url), :class => 'url') unless plugin.url.blank? %>
  </td>
  <td class="author"><%= plugin.author_url.blank? ? plugin.author : link_to(plugin.author, plugin.author_url) %></td>
  <td class="version"><span class="icon"><%= plugin.version %></span></td>
  <td class="configure"><%= link_to(l(:button_configure), plugin_settings_path(plugin)) if plugin.configurable? %></td>
  </tr>
<% end %>
```

---

# Plugin Loader

```ruby
class PluginLoader
  # Absolute path to the directory where plugins are located
  cattr_accessor :directory
  self.directory = Rails.root.join('plugins')

  # ...

  def self.load
    setup
    add_autoload_paths

    Rails.application.config.to_prepare do
      PluginLoader.directories.each(&:run_initializer)

      Redmine::Hook.call_hook :after_plugins_loaded
    end
  end
  # ..
end
```


---

<!-- header: "" -->


# ActiveJob

- adapter
- hooks

---
<!-- header: "ActiveJob" -->

```ruby
class MyJob < ActiveJob::Base
  queue_as :my_jobs

  def perform(record)
    record.do_work
  end
end
```

---

<!-- header: ActiveJob -->

```ruby
class InlineAdapter
  def enqueue(job) # :nodoc:
    Base.execute(job.serialize)
  end

  def enqueue_at(*) # :nodoc:
    raise NotImplementedError, "Use a queueing backend to enqueue..."
  end
end

ActiveJob::Base.queue_adapter = :inline
```

---


```ruby

module ActiveJob
  module Execution
    # Includes methods for executing and performing jobs instantly.
    module ClassMethods
      def perform_now(...)
        job_or_instantiate(...).perform_now
      end

      def execute(job_data) # :nodoc:
        ActiveJob::Callbacks.run_callbacks(:execute) do
          job = deserialize(job_data)
          job.perform_now
        end
      end
    end
  end
end
```

---
<!-- header: "" -->

# Faraday

- adapter

---
<!-- header: Faraday -->


```ruby
Faraday.new(...) do |f|
  f.adapter :florp_http, pool_size: 5 do |client|
    client.some_fancy_florp_http_property = 10
  end
end
```

---

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
```

---

```ruby
ruby2_keywords def adapter(klass = NO_ARGUMENT, *args, &block)
  return @adapter if klass == NO_ARGUMENT || klass.nil?

  klass = Faraday::Adapter.lookup_middleware(klass) if klass.is_a?(Symbol)
  @adapter = self.class::Handler.new(klass, *args, &block)
end

```


---
<!-- header: "" -->

# Jekyll

- tag
- converter
- hooks
- generator

---
<!-- header: Jekyll -->


# Liquid Tag

```ruby
class YouTubeEmbed < Liquid::Tag
  def initiliaze(tagName, content, tokens)
    # ...
  end
  def render(conext)
    # ...
  end
end

Liquid::Template.register_tag "youtube", YouTubeEmbed
```

---

# Converter

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

---

# Converter Register

```ruby
def setup
  ensure_not_in_dest

  plugin_manager.conscientious_require

  self.converters = instantiate_subclasses(Jekyll::Converter)
  self.generators = instantiate_subclasses(Jekyll::Generator)
end
```


---

# Hook

```ruby
# describe
Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  Jekyll::Emoji.emojify(doc) if Jekyll::Emoji.emojiable?(doc)
end


# regsiter
def self.insert_hook(owner, event, priority, &block)
  @hook_priority[block] = [-priority, @hook_priority.size]
  @registry[owner][event] << block
end

# Call
Jekyll::Hooks.trigger :site, :after_init, self
```

---

# Hooks


```ruby
@registry = {
  :site      => {
    :after_init  => [],
    :after_reset => [],
    :post_read   => [],
    :pre_render  => [],
    # ...
  },
  :pages     => {
    :post_init    => [],
    :pre_render   => [],
    :post_convert => [],
    # ...
  },
  # ...
}
```

---
<!-- header: "" -->

# Rack

- middleware

---
<!-- header: Rack -->

```ruby
class Middleware
  def initialize(app)
    @app = app
  end

  def call(env)
    env["rack.some_header"] = "setting an example"
    @app.call(env)
  end
end

use Middleware
run lambda { |env| [200, { "content-type" => "text/plain" }, ["OK"]] }
```

---

```ruby
def use(middleware, *args, &block)
  # ...
  @use << proc { |app| middleware.new(app, *args, &block) }
end
```

```ruby
def to_app
  # ..
  app = @use.reverse.inject(app) { |a, e| e[a].tap { |x| x.freeze if @freeze_app } }
  @warmup.call(app) if @warmup
  app
end
```

---

# Pipeline

TODO

Composition

```ruby
# Code here
```



---
<!-- header: "" -->

# Warden

- hooks (как называется?)
- auth strategies
- failure_app

---
<!-- header: Warden -->

# Callbacks

```ruby
Warden::Manager.after_set_user do |user, auth, opts|
  unless user.active?
    auth.logout
    throw(:warden, :message => "User not active")
  end
end
```

---

# Strategy

TODO можно ли несколько стратегий сразу?

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

---

# Strategy


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

---

# Failure App

```ruby
manager.failure_app = Proc.new { |_env|
  ['401', {'Content-Type' => 'application/json'}, { error: 'Unauthorized', code: 401 }]
}
```

---

<!-- header: "" -->

# Summary

---

<!-- header: "Summary" -->

# Ways to Go

1. configuration
1. inheritance
1. composition 
1. dependency injection
1. strategy 
1. observer
1. adapter
1. pipeline
1. DSL

---

# Warning!

1. monkey patching
2. method overriding
3. complex API

---

# Summary

1. OCP exists
2. separate different code
3. not only for gems

---

# Links

1. https://github.com/sergio-fry/slides/blob/master/ocp/slides.md
2. https://blog.cleancoder.com/uncle-bob/2014/05/12/TheOpenClosedPrinciple.html
3. https://web.archive.org/web/20150905081105/http://www.objectmentor.com/resources/articles/ocp.pdf

---

# Thanks!

Sergei Udalov. Balance Platform
