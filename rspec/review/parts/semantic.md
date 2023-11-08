```ruby

FactoryBot.define do
  factory :user, aliases: [:author, :assignee, :recipient, :owner, :resource_owner] do
    email { generate(:email) }
    name { generate(:name) }
    # ..
  end
end
```
https://github.com/gitlabhq/gitlabhq/blob/652dfd8e201e1cf15fc720e0ab96a9ae4c691503/spec/factories/users.rb#L4


---

```ruby
def textdec_timestamptz_decode_should_fail(str)
  expect(textdec_timestamptz.decode(str)).to eq(str)
end

it 'fails when the timestamp is an empty string' do
  textdec_timestamptz_decode_should_fail('')
end
```

https://github.com/ged/ruby-pg/blob/1c67bbf1cb858634578a56e77f34270b938b9d0a/spec/pg/type_spec.rb
