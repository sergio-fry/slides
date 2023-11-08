

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

