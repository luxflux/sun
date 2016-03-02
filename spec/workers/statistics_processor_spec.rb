require 'rails_helper'

RSpec.describe StatisticsProcessor do
  let(:instance) { StatisticsProcessor.new }
  let(:location_name) { 'somewhere' }
  let(:port_number) { 1 }
  let(:value) { 100 }
  let(:signal_type) { 'analog' }
  let(:timestamp) { Time.now.to_i }

  before do
    allow(Keen).to receive(:publish)
  end

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

    it 'writes a datapoint' do
      expected_name = "#{location_name}.port-#{port_number}"
      expected_data = {
        location: location_name,
        port: port_number,
        value: value,
        keen: {
          timestamp: Time.now.iso8601
        }
      }
      expect(Keen).to receive(:publish).with(expected_name, expected_data)
      subject
    end
  end
end
