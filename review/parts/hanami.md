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

