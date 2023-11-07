```ruby

			it "should decode integers of different lengths from text format" do
				30.times do |zeros|
					expect( textdec_int.decode("1" + "0"*zeros) ).to eq( 10 ** zeros )
					expect( textdec_int.decode(zeros==0 ? "0" : "9"*zeros) ).to eq( 10 ** zeros - 1 )
					expect( textdec_int.decode("-1" + "0"*zeros) ).to eq( -10 ** zeros )
					expect( textdec_int.decode(zeros==0 ? "0" : "-" + "9"*zeros) ).to eq( -10 ** zeros + 1 )
				end
				66.times do |bits|
					expect( textdec_int.decode((2 ** bits).to_s) ).to eq( 2 ** bits )
					expect( textdec_int.decode((2 ** bits - 1).to_s) ).to eq( 2 ** bits - 1 )
					expect( textdec_int.decode((-2 ** bits).to_s) ).to eq( -2 ** bits )
					expect( textdec_int.decode((-2 ** bits + 1).to_s) ).to eq( -2 ** bits + 1 )
				end
			end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_spec.rb


```ruby

				it 'fails when the timestamp is an empty string' do
					textdec_timestamptz_decode_should_fail('')
				end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_spec.rb



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


```ruby

	it "should check format when deleting coders" do
		expect{ tm_writable.rm_coder(2, 123) }.to raise_error(ArgumentError)
		expect{ tm_writable.rm_coder(-1, 123) }.to raise_error(ArgumentError)
	end

```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_map_by_oid_spec.rb



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
https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/helpers/tcp_gate_switcher.rb


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

```ruby

		it "should tell about pipeline mode", :postgresql_14 do
			@conn.enter_pipeline_mode
			expect( @conn.inspect ).to match(/ pipeline_status=PQ_PIPELINE_ON/)
		end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/connection_spec.rb

```ruby

		it "shouldn't accept invalid return from fit_to_copy_get" do
			tm = Class.new(PG::TypeMapInRuby) do
				def fit_to_copy_get
					:invalid
				end
			end.new.freeze

			ce = PG::TextDecoder::CopyRow.new(type_map: tm).freeze
			expect{ ce.decode("5\t6\n") }.to raise_error(TypeError, /kind of Integer/)
		end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_map_in_ruby_spec.rb


