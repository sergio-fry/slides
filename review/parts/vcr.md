```ruby

        allow(config).to receive(:logger).and_return(double.as_null_object)
```

https://github.com/vcr/vcr/blob/master/spec/lib/vcr/cassette/http_interaction_list_spec.rb


```ruby

    describe 'clean_outdated_http_interactions' do
      before(:each) do
        subject.instance_variable_set(:@clean_outdated_http_interactions, true)
        subject.instance_variable_set(:@previously_recorded_interactions, subject.instance_variable_get(:@new_recorded_interactions))
        subject.instance_variable_set(:@new_recorded_interactions, [])
      end
```

https://github.com/vcr/vcr/blob/master/spec/lib/vcr/cassette_spec.rb

```ruby

      it 'returns false when there is an existing cassette file with content' do
        cassette = VCR::Cassette.new("example", :record => :once)
        expect(::File).to exist(cassette.file)
        expect(::File.size?(cassette.file)).to be_truthy
        expect(cassette).not_to be_recording
      end
```

https://github.com/vcr/vcr/blob/master/spec/lib/vcr/cassette_spec.rb


```ruby

  context 'when used in a multithreaded environment with a cassette', :with_monkey_patches => :excon do
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
        recorded_content_for("foo")).to include("FOO!")
    end
```

https://github.com/vcr/vcr/blob/master/spec/acceptance/concurrency_spec.rb
