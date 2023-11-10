# Acceptance

---

```ruby
specify 'types from a provided types module can be used as setting constructors to coerce values' do
  with_tmp_directory(Dir.mktmpdir) do
    write 'config/app.rb', <<~RUBY
      require "hanami"

      module TestApp
        class App < Hanami::App
        end
      end
    RUBY

    write 'config/settings.rb', <<~RUBY
      module TestApp
        class Settings < Hanami::Settings
          Bool = Types::Params::Bool

          setting :numeric, constructor: Types::Params::Integer
          setting :flag, constructor: Bool
        end
      end
    RUBY

    ENV['NUMERIC'] = '42'
    ENV['FLAG'] = 'true'

    require 'hanami/prepare'

    expect(Hanami.app['settings'].numeric).to eq 42
    expect(Hanami.app['settings'].flag).to be true
  end
end
```

<a class="link--source" href="https://github.com/hanami/hanami/blob/a2bdb77f10d7873e0685f47317583a581/spec/integration/settings/using_types_spec.rb">https://github.com/hanami/hanami/blob/a2bdb77f10d787/spec/integration/settings/using_types_spec.rb</a>


---

```ruby
context 'when used in a multithreaded environment with a cassette', with_monkey_patches: :excon do
  it 'properly stubs threaded requests' do
    VCR.use_cassette('/foo') do
      threads = 50.times.map do
        Thread.start do
          Excon.get "http://localhost:#{VCR::SinatraApp.port}/foo"
        end
      end
      threads.each(&:join)
    end

    expect(
      recorded_content_for('foo')
    ).to include('FOO!')
  end
end
```

<a class="link--source" href="https://github.com/vcr/vcr/blob/master/spec/acceptance/concurrency_spec.rb">https://github.com/vcr/vcr/blob/master/spec/acceptance/concurrency_spec.rb</a>


---
