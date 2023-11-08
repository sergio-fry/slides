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

