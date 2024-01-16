class Interactor
  def initialize(rmq:)
    @rmq = rmq
  end

  def call
    @rmq.produce
  end
end

RSpec.describe "expect to receive" do
  context "when AAA is broken" do
    # Arrange
    let(:rmq) { double(:rmq) }
    let(:interactor) { Interactor.new(rmq:) }

    it do
      expect(rmq).to receive(:produce) # Assert
      interactor.call # Act
    end
  end

  context "when AAA is fixed" do
    # Arrange
    let(:rmq) { spy(:rmq) } # <-- SPY
    let(:interactor) { Interactor.new(rmq:) }

    it do
      interactor.call # Act
      expect(rmq).to have_receive(:produce) # Assert
    end
  end
end
