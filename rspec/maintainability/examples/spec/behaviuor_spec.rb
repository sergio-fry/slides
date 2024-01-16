RSpec.describe "Behaviour" do
  example do
    expect(interactor).to receive(:log_error)
      .with("validation failed")
    interactor.call
  end

  example do
    result = interactor.call
    expect(result.error).to eq "validation failed"
  end
end
