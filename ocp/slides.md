---

paginate: true
class: lead
marp: true
size: 4:3
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

Robert C. Martin

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

1. Enumerable
2. Logger
3. Redmine
4. Jekyll
5. ActiveJob
6. Rack
7. Warden

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

1. level
2. device
3. formatter

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

# Formatter

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
    format_message(format_severity(severity), Time.now, progname, message)
  )
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

1. Rails Engine: controllers, views, models, ...
2. settings
3. hooks


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
      <%= content_tag('span', plugin.description, :class => 'description')
        unless plugin.description.blank? %>
      <%= content_tag('span', link_to(plugin.url, plugin.url), :class => 'url')
        unless plugin.url.blank? %>
  </td>
  <td class="author"><%= plugin.author_url.blank? ? plugin.author :
    link_to(plugin.author, plugin.author_url) %></td>
  <td class="version"><span class="icon"><%= plugin.version %></span></td>
  <td class="configure"><%= link_to(l(:button_configure), plugin_settings_path(plugin))
    if plugin.configurable? %></td>
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

# Jekyll

1. Liquid: tags, filters
2. converter
3. hooks
4. generator

---
<!-- header: Jekyll -->

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

# Register Converter

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
def self.insert_hook(owner, event, priority, &block)
  @hook_priority[block] = [-priority, @hook_priority.size]
  @registry[owner][event] << block
end

# register
Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  Jekyll::Emoji.emojify(doc) if Jekyll::Emoji.emojiable?(doc)
end

# invoke
Jekyll::Hooks.trigger :site, :after_init, self
```

---

# Available Hooks


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


# ActiveJob

1. adapter
2. hooks
3. serializer

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
  module Enqueuing
    module ClassMethods
      def perform_later(...)
        job = job_or_instantiate(...)
        enqueue_result = job.enqueue
	# ..
      end
    end

    def enqueue(options = {})
      # ..

      run_callbacks :enqueue do
        if scheduled_at
          queue_adapter.enqueue_at self, scheduled_at
        else
          queue_adapter.enqueue self
        end
	# ..
      end
	# ..
    end
  end
end
```


---

# Callbacks

```ruby
class VideoProcessJob < ActiveJob::Base
  queue_as :default

  before_perform do |job|
    UserMailer.notify_video_started_processing(job.arguments.first)
  end

  def perform(video_id)
    Video.find(video_id).process
  end
end
```

---

# Define Callback

```ruby
class Record
  include ActiveSupport::Callbacks
  define_callbacks :save

  def save
    run_callbacks :save do
      puts "- save"
    end
  end
end
```

---

# Register Callback

```ruby
class PersonRecord < Record
  set_callback :save, :before, :saving_message
  def saving_message
    puts "saving..."
  end

  set_callback :save, :after do |object|
    puts "saved"
  end
end
```


---
<!-- header: "" -->

# Rack

- middleware

---
<!-- header: Rack -->

```ruby
class TimeNow
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    [status, headers.merge("time" => Time.now.to_s) , body]
  end
end

use TimeNow
run lambda { |env| [200, { "content-type" => "text/plain" }, ["OK"]] }
```

---

```ruby
def use(middleware, *args, &block)
  # ...
  @use << proc { |app| middleware.new(app, *args, &block) }
end

def to_app
  # ..
  app = @use.reverse.inject(app) { |a, e| e[a].tap { |x| x.freeze if @freeze_app } }
  @warmup.call(app) if @warmup
  app
end
```

---

# Pipeline

```ruby
# config.ru

use TimeNow
use Rack::Runtime
use Rack::ETag

run App.new
```


---

# Composition


```ruby
# meta language
TimeNow.new(
  Rack::Runtime.new(
    Rack::ETag.new(
      App.new
    )
  )
)
```


---
<!-- header: "" -->

# Warden

1. auth strategies
2. hooks
3. failure_app

---
<!-- header: Warden -->

# Register Strategy

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

# Inheritance

```ruby
class PasswordStrategy < Warden::Strategies::Base
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

# Configure

```ruby
use Warden::Manager do |manager|
  manager.default_strategies :password, :basic
  manager.failure_app = BadAuthenticationEndsUpHere
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


# Describe Hook

```ruby
def after_set_user(options = {}, method = :push, &block)
  raise BlockNotGiven unless block_given?

  if options.key?(:only)
    options[:event] = options.delete(:only)
  elsif options.key?(:except)
    options[:event] = [:set_user, :authentication, :fetch] - Array(options.delete(:except))
  end

  _after_set_user.send(method, [block, options])
end
```

---

# Register Hook

```ruby
Warden::Manager.after_set_user do |user, auth, opts|
  unless user.active?
    auth.logout
    throw(:warden, :message => "User not active")
  end
end
```

---


# Failure App

```ruby
manager.failure_app = Proc.new { |_env|
  [401, {'Content-Type' => 'text/plain'}, ['No Access']]
}
```

---

<!-- header: "" -->

# Summary

---

<!-- header: "Summary" -->

# Ways to Go

1. inheritance
2. composition 
3. observer
4. adapter
5. pipeline
6. DSL

---

# Try not to

1. monkey patching
2. method overriding
3. complex API
4. type casting

---

# Summary

1. OCP exists
2. separate different code
3. abstractions
4. not only for gems

---

# Links

1. https://github.com/sergio-fry/slides/blob/master/ocp/slides.md
2. https://blog.cleancoder.com/uncle-bob/2014/05/12/TheOpenClosedPrinciple.html
3. https://web.archive.org/web/20150905081105/http://www.objectmentor.com/resources/articles/ocp.pdf
4. "Design Patterns in Ruby", *Russ Olsen*

---

# Thanks!

Sergei O. Udalov, Balance Platform
sergei@udalovs.ru
