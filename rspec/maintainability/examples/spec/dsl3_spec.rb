module TestingDsl
  class Company
    def initialize(kafka:)
      @kafka = kafka
    end

    def hire(employee)
      @kafka.produce({
                       type: "hired",
                       item_id: employee.id
                     })
    end
  end

  class Employee
    attr_reader :id

    def initialize
      @id = rand
    end
  end

  class FakeKafka
    attr_reader :produced_messages

    def initialize
      @produced_messages = []
    end

    def produce(message)
      @produced_messages << message
    end
  end

  RSpec::Matchers.define :produce_event_of_type do |type|
    match do |actual|
      actual.call

      message = kafka.produced_messages.find { |msg| msg[:type] == type.to_s }
      message[:item_id] == @item_id
    end

    chain :for_item do |item_id|
      @item_id = item_id
    end

    supports_block_expectations
  end

  RSpec.describe "DSL" do
    let(:company) { Company.new(kafka:) }
    let(:new_employee) { Employee.new }
    let(:kafka) { FakeKafka.new }

    describe "verbose mode" do
      it {
        company.hire new_employee

        message = kafka.produced_messages.find { |msg| msg[:type] == "hired" }
        expect(message[:item_id]).to eq new_employee.id
      }
    end

    describe "DSL mode" do
      it {
        expect { company.hire(new_employee) }
          .to produce_event_of_type(:hired)
          .for_item(new_employee.id)
      }
    end
  end
end
