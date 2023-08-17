module HaveTesting
  class Response
    def has_body?
      true
    end
  end
end

RSpec.describe "have" do
  subject { HaveTesting::Response.new }

  it { is_expected.to have_body }
  it { is_expected.to have(2).items }
end
