---


```ruby

      it 'should update a registered observer without arguments' do
        expect(observer).to receive(:update).with(no_args)

        observer_set.add_observer(observer)

        observer_set.notify_observers
      end
```

https://github.com/ruby-concurrency/concurrent-ruby/blob/master/spec/concurrent/collection/observer_set_shared.rb#L29


---

```ruby
    it 'returns Concurrent::NULL immediately if no item is available' do
      expect(subject.poll).to eq Concurrent::NULL
    end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/channel/buffer/base_shared.rb#L96

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

```



---

# Bonus

```ruby
      specify '#to_s formats as a time', :truffle_bug => true do
        expect(subject.to_s).to match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{6} \+\d{4} UTC/)
      end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/master/spec/concurrent/channel/tick_spec.rb#L31C1-L31C1


---

```ruby
RSpec.describe JavaSingleThreadExecutor, :type=>:jruby do

      after(:each) do
        subject.shutdown
        expect(subject.wait_for_termination(pool_termination_timeout)).to eq true
      end

      subject { JavaSingleThreadExecutor.new }

      it_should_behave_like :executor_service
    end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/executor/java_single_thread_executor_spec.rb#L8

---


```ruby
      subject do
        Class.new {
          def zero() nil; end
          def three(a, b, c, &block) nil; end
          def two_plus_two(a, b, c=nil, d=nil, &block) nil; end
          def many(*args, &block) nil; end
        }.new
      end
```
https://github.com/ruby-concurrency/concurrent-ruby/blob/1982b92daa8aee0d88db5212a61b790142c4106f/spec/concurrent/async_spec.rb#L78-L85


