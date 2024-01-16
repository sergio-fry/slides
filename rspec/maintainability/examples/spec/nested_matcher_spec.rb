RSpec.describe "nested matcher" do
  subject { { user: { name: "Ivan", age: 23, updated_at: Time.now.to_s } } }

  it { is_expected.to match(user: hash_including({ name: "Ivan" })) }

  describe do
    let(:user_id) { 1 }
    subject do
      {
        time: Time.now,
        user_ids: [user_id, 4, 2],
        meta: { x_time: 1.23 }
      }
    end

    it do
      is_expected.to match(
        hash_including(
          time: kind_of(Time),
          user_ids: array_including(user_id),
          meta: hash_including(x_time: anything)
        )
      )
    end
  end
end
