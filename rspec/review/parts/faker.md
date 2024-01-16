# Faker
5 из 8

---

<!-- header: Faker 5 из 8 -->

![bg](img/bg/hanami.png)

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

<a class="link--source" href="https://github.com/hanami/hanami/blob/675b44/spec/integration/logging/exception_logging_spec.rb">https://github.com/hanami/hanami/blob/675b44/spec/integration/logging/exception_logging_spec.rb</a>

---

![bg](img/bg/pg.png)

# TcpGateSwitcher 1/2

```ruby

# This is a transparent TCP proxy for testing blocking behaviour in a time insensitive way.
#
# It works as a gate between the client and the server, which is enabled or disabled by the spec.
# Data transfer can be blocked per API.
# The TCP communication in a C extension can be verified in a (mostly) timing insensitive way.
# If a call does IO but doesn't handle non-blocking state, the test will block and can be caught by an external timeout.
#
#
#   PG.connect                    TcpGateSwitcher
#    port:5444        .--------------------------------------.
#        .--start/stop---------------> T                     |         DB
#  .-----|-----.      |                | /                   |      .------.
#  |    non-   |      |                |/                    |      |Server|
#  |  blocking |      | TCPServer      /           TCPSocket |      | port |
#  |   specs   |------->port 5444-----/   ---------port 5432------->| 5432 |
#  '-----------'      '--------------------------------------'      '------'

```
<a class="link--source" href="https://github.com/ged/ruby-pg/blob/1c67bb/spec/helpers/tcp_gate_switcher.rb">https://github.com/ged/ruby-pg/blob/1c67bb/spec/helpers/tcp_gate_switcher.rb</a>

---
<style scoped>
.hljs-comment { color: red; background: yellow }
</style>

![bg](img/bg/pg.png)

# TcpGateSwitcher 2/2

```ruby
run_with_gate(200) do |conn, gate|
  conn.setnonblocking(true)

  gate.stop # ТУТ
  data = 'x' * 1000 * 1000 * 30
  res = conn.send_query_params('SELECT LENGTH($1)',
    [data])
  expect(res).to be_nil

  res = conn.flush
  expect(res).to be_falsey

  gate.start # И ЗДЕСЬ
  IO.select(
    nil, [conn.socket_io], [conn.socket_io], 10
  ) until conn.flush
  expect(conn.flush).to be_truthy

  res = conn.get_last_result
  expect(res.values).to eq([[data.length.to_s]])
end
                                                                                      
```

<a class="link--source" href="https://github.com/ged/ruby-pg/blob/2218ebf0b5a6057e74cd4d628e0b20011b8c0aff/spec/pg/connection_spec.rb">https://github.com/ged/ruby-pg/blob/2218eb/spec/pg/connection_spec.rb</a>

---

<!-- header: "" -->
