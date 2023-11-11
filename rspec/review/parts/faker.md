
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

TODO: add usage

---
