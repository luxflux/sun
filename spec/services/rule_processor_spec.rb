require 'rails_helper'

RSpec.describe RuleProcessor do
  let(:rule) { FactoryGirl.create :rule }
  let(:sneakers_publisher_double) { instance_double(Sneakers::Publisher) }
  let(:instance) { RuleProcessor.new(rule) }

  before do
    allow(Sneakers::Publisher).to receive(:new).and_return(sneakers_publisher_double)
    allow(sneakers_publisher_double).to receive(:publish)
  end

  describe '.call' do
    it 'calls #call on the instance' do
      rule_processor_double = instance_double(RuleProcessor)
      expect(RuleProcessor).to receive(:new).with(rule).and_return(rule_processor_double)
      expect(rule_processor_double).to receive(:call)
      RuleProcessor.call(rule)
    end
  end

  describe '#call' do
    subject { instance.call }

    it { is_expected.to eq(true) }

    it 'sends all the relevant info in the message' do
      expected_data = {
        location: rule.output.location.name,
        port: rule.output.number,
        state: rule.state,
      }.to_json
      expect(sneakers_publisher_double).to receive(:publish).with(expected_data, to_queue: String)
      subject
    end
  end

  describe '#queue' do
    subject { instance.queue }

    it { is_expected.to eq("actions.#{rule.output.location.name}.port-#{rule.output.number}") }
  end
end
