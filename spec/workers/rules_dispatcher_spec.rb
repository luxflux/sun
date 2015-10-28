require 'rails_helper'

RSpec.describe RulesDispatcher do
  let(:instance) { RulesDispatcher.new }
  let(:location_name) { 'somewhere' }
  let(:port_number) { 1 }
  let(:value) { 100 }
  let(:signal_type) { 'analog' }
  let(:timestamp) { Time.now.to_i }
  let!(:location) { FactoryGirl.create :location, name: location_name }
  let!(:input) { FactoryGirl.create :input, location: location }

  describe '#work' do
    let(:message) do
      {
        'location' => location_name,
        'port' => port_number,
        'type' => signal_type,
        'value' => value,
        'timestamp' => timestamp,
      }.to_json
    end

    subject { instance.work(message) }

    context 'no error raised' do
      it 'acknowledges the message' do
        expect(instance).to receive(:ack!)
        subject
      end
    end

    context 'error raised' do
      it 'does not acknowledge the message' do
        expect(instance).to_not receive(:ack!)
        expect(JSON).to receive(:parse).and_raise(ArgumentError)
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'one rule matches' do
      let(:rule) { FactoryGirl.create :rule, input: input, rule: :higher, threshold: 1, state: 'on' }

      it 'calls RuleProcessor#call' do
        expect(RuleProcessor).to receive(:call).with(rule)
        subject
      end
    end
  end
end
