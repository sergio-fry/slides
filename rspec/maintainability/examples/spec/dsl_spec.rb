RSpec.describe "DSL" do
  describe "verbose mode" do
    it { expect(response["data"]["errors"]).to be_empty }

    it do
      expect(Rails.logger).to receive(:errors).with(/Cant calculate salary/)
      report.build
    end

    context "Invalid String given" do
      let(:phone_number) { "242513" }

      it "should fail" do
        errors = gql_query_errors(query)
        expect(errors[0]["message"]).to start_with "Argument 'number' on Field 'validatePhoneNumber'"
      end

      context "with string without digits" do
        let(:phone_number) { "asdasdsadsadasd" }

        it "should fail" do
          errors = gql_query_errors(query)
          expect(errors[0]["message"]).to start_with "Argument 'number' on Field 'validatePhoneNumber'"
        end
      end
    end
  end

  describe "DSL mode" do
    it { expect(response).not_to have_errors }

    it { expect { report.build }.to fail_with_error(/Cant calculate salary/) }

    context "Invalid String given" do
      it { expect(phone_validation_error("242513")).to start_with "Argument 'number' on Field 'validatePhoneNumber'" }
      it {
        expect(phone_validation_error("asdasdsadsadasd")).to start_with "Argument 'number' on Field 'validatePhoneNumber'"
      }
    end
  end
end
