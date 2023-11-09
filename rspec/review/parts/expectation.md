


```ruby
it "returns a new instance" do
  expect(none).to eql(None())
  expect(none.trace).to include("spec/integration/maybe_spec.rb:9:in `block")
end
```
https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/integration/maybe_spec.rb#L17C1-L20C10



```ruby
RSpec.describe(Dry::Monads) do
  let(:m) { described_class }
  list = Dry::Monads::List

  it "builds a list with List[]" do
    expect(instance.make_list).to eql(list[1, 2, 3])
  end
end
```

https://github.com/dry-rb/dry-monads/blob/704c1bfdfd27be7677b5f875ac59585173a8237e/spec/integration/monads_spec.rb#L5


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

---


```ruby

  describe "sessions" do
    specify { expect(config.sessions).not_to be_enabled }
  end

```
https://github.com/hanami/hanami/blob/a2bdb77f10d7873e0685f47317583a581f382d02/spec/unit/hanami/config/actions/default_values_spec.rb

---



```ruby
	let!(:textdec_int){ PG::TextDecoder::Integer.new(name: 'INT4', oid: 23).freeze }
	let!(:textdec_float){ PG::TextDecoder::Float.new(name: 'FLOAT8', oid: 701).freeze }
	let!(:textdec_string){ PG::TextDecoder::String.new(name: 'TEXT', oid: 25).freeze }
	let!(:textdec_bytea){ PG::TextDecoder::Bytea.new(name: 'BYTEA', oid: 17).freeze }
	let!(:binarydec_float){ PG::BinaryDecoder::Float.new(name: 'FLOAT8', oid: 701, format: 1).freeze }
	let!(:tm) do
		tm = PG::TypeMapByOid.new
		tm.add_coder textdec_int
		tm.add_coder textdec_float
		tm.add_coder binarydec_float
		tm.add_coder pass_through_type
		tm.freeze
	end
	it "should retrieve it's conversions" do
		expect( tm.coders ).to eq( [
			textdec_int,
			textdec_float,
			pass_through_type,
			binarydec_float,
		] )
	end
```
https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_map_by_oid_spec.rb

---


```ruby

	it "should check format when deleting coders" do
		expect{ tm_writable.rm_coder(2, 123) }.to raise_error(ArgumentError)
		expect{ tm_writable.rm_coder(-1, 123) }.to raise_error(ArgumentError)
	end

```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_map_by_oid_spec.rb

---


```ruby

			[1, 0].each do |format|
				it "should convert format #{format} timestamps per TimestampUtcToLocal" do
					regi = PG::BasicTypeRegistry.new
					regi.register_type 0, 'timestamp', nil, PG::TextDecoder::TimestampUtcToLocal
					regi.register_type 1, 'timestamp', nil, PG::BinaryDecoder::TimestampUtcToLocal
					@conn.type_map_for_results = PG::BasicTypeMapForResults.new(@conn, registry: regi)
					res = @conn.exec_params( "SELECT CAST('2013-07-31 23:58:59+02' AS TIMESTAMP WITHOUT TIME ZONE),
																		CAST('1913-12-31 23:58:59.1231-03' AS TIMESTAMP WITHOUT TIME ZONE),
																		CAST('4714-11-24 23:58:59.1231-03 BC' AS TIMESTAMP WITHOUT TIME ZONE),
																		CAST('294276-12-31 23:58:59.1231-03' AS TIMESTAMP WITHOUT TIME ZONE),
																		CAST('infinity' AS TIMESTAMP WITHOUT TIME ZONE),
																		CAST('-infinity' AS TIMESTAMP WITHOUT TIME ZONE)", [], format )
					expect( res.getvalue(0,0).iso8601(3) ).to eq( Time.utc(2013, 7, 31, 23, 58, 59).getlocal.iso8601(3) )
					expect( res.getvalue(0,1).iso8601(3) ).to eq( Time.utc(1913, 12, 31, 23, 58, 59.1231).getlocal.iso8601(3) )
					expect( res.getvalue(0,2).iso8601(3) ).to eq( Time.utc(-4713, 11, 24, 23, 58, 59.1231).getlocal.iso8601(3) )
					expect( res.getvalue(0,3).iso8601(3) ).to eq( Time.utc(294276, 12, 31, 23, 58, 59.1231).getlocal.iso8601(3) )
					expect( res.getvalue(0,4) ).to eq( 'infinity' )
					expect( res.getvalue(0,5) ).to eq( '-infinity' )
				end
			end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/basic_type_map_for_results_spec.rb


---




```ruby

      expect(DRb).not_to have_running_server

      expect {
        Bisect::Server.run do
          expect(DRb).to have_running_server
          raise "boom"
        end
      }.to raise_error("boom")
```

https://github.com/rspec/rspec-core/blob/1eeadce5aa7137ead054783c31ff35cbfe9d07cc/spec/rspec/core/bisect/server_spec.rb

---



```ruby
    specify "#to_s" do
      channel = Concurrent::Promises::Channel.new
      expect(channel.to_s).to match(/Channel.*unlimited/)
      channel = Concurrent::Promises::Channel.new 2
      expect(channel.to_s).to match(/Channel.*0.*2/)
      channel.push :value
      expect(channel.to_s).to match(/Channel.*1.*2/)
    end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/edge/channel_spec.rb#L10C1-L17C8


---


```ruby

    specify "#(try_)push(_op)" do
      channel = Concurrent::Promises::Channel.new 1

      expect(channel.size).to eq 0
      expect(channel.try_push(:v1)).to be_truthy
      expect(channel.size).to eq 1
      expect(channel.try_push(:v2)).to be_falsey
      expect(channel.size).to eq 1

      channel = Concurrent::Promises::Channel.new 1
      expect(channel.push(:v1)).to eq channel
      expect(channel.size).to eq 1
      thread = in_thread { channel.push :v2 }
      is_sleeping thread
      expect(channel.size).to eq 1
      channel.pop
      expect(channel.size).to eq 1
      expect(thread.value).to eq channel
      channel.pop
      expect(channel.size).to eq 0

      channel = Concurrent::Promises::Channel.new 1
      expect(channel.push(:v1)).to eq channel
      expect(channel.size).to eq 1
      thread = in_thread { channel.push :v2, 0.01 }
      is_sleeping thread
      expect(channel.size).to eq 1
      expect(thread.value).to eq false
      channel.pop
      expect(channel.size).to eq 0
      expect(channel.push(:v3, 0)).to eq true
      expect(channel.size).to eq 1
      thread = in_thread { channel.push :v2, 1 }
      is_sleeping thread
      channel.pop
      expect(channel.size).to eq 1
      expect(thread.value).to eq true

      channel = Concurrent::Promises::Channel.new 1
      expect(channel.push_op(:v1).value!).to eq channel
      expect(channel.size).to eq 1
      push_op = channel.push_op :v2
      expect(channel.size).to eq 1
      expect(push_op.pending?).to be_truthy
      channel.pop
      expect(channel.size).to eq 1
      expect(push_op.value!).to eq channel
      channel.pop
      expect(channel.size).to eq 0
    end

```
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/edge/channel_spec.rb#L19


---



```ruby
      it 'sets :max_length to DEFAULT_MAX_POOL_SIZE' do
        expect(subject.max_length).to eq described_class::DEFAULT_MAX_POOL_SIZE
      end
```

https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/executor/cached_thread_pool_spec.rb#L25C9-L25C9

---

# Bonus

```ruby
      specify '#to_s formats as a time', :truffle_bug => true do
        expect(subject.to_s).to match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6} \+\d{4} UTC/)
      end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/master/spec/concurrent/channel/tick_spec.rb#L31C1-L31C1

