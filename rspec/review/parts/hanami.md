---

```ruby
  let(:logger_stream) { StringIO.new }

  def configure_logger
    Hanami.app.config.logger.stream = logger_stream
  end

  def logs
    @logs ||= (logger_stream.rewind and logger_stream.read)
  end

   expect(logs).to match %r{GET 404 \d+(µs|ms) 127.0.0.1 /}
```

https://github.com/hanami/hanami/blob/675b441c3f0a64f980f78c6b05e61be0ab61caa5/spec/integration/logging/exception_logging_spec.rb#L6


```ruby

  specify "types from a provided types module can be used as setting constructors to coerce values" do
    with_tmp_directory(Dir.mktmpdir) do
      write "config/app.rb", <<~RUBY
        require "hanami"

        module TestApp
          class App < Hanami::App
          end
        end
      RUBY

      write "config/settings.rb", <<~RUBY
        module TestApp
          class Settings < Hanami::Settings
            Bool = Types::Params::Bool

            setting :numeric, constructor: Types::Params::Integer
            setting :flag, constructor: Bool
          end
        end
      RUBY

      ENV["NUMERIC"] = "42"
      ENV["FLAG"] = "true"

      require "hanami/prepare"

      expect(Hanami.app["settings"].numeric).to eq 42
      expect(Hanami.app["settings"].flag).to be true
    end
  end
```
https://github.com/hanami/hanami/blob/a2bdb77f10d7873e0685f47317583a581f382d02/spec/integration/settings/using_types_spec.rb

```ruby

  it "renders <video> tag" do
    actual = video_tag("movie.mp4").to_s
    expect(actual).to eq(%(<video src="/assets/movie.mp4"></video>))
  end
```
https://github.com/hanami/hanami/blob/a2bdb77f10d7873e0685f47317583a581f382d02/spec/unit/hanami/helpers/assets_helper/video_tag_spec.rb


```ruby

  describe "sessions" do
    specify { expect(config.sessions).not_to be_enabled }
  end

```
https://github.com/hanami/hanami/blob/a2bdb77f10d7873e0685f47317583a581f382d02/spec/unit/hanami/config/actions/default_values_spec.rb
