require 'rails_helper'

RSpec.describe StatisticsProcessor do
  let(:instance) { StatisticsProcessor.new }
  let(:location_name) { 'somewhere' }
  let(:port_number) { 1 }
  let(:value) { 100 }
  let(:signal_type) { 'analog' }
  let(:timestamp) { Time.now.to_i }
  let(:influx_client_double) { instance_double(InfluxDB::Client) }

  before do
    allow(InfluxDB::Client).to receive(:new).and_return(influx_client_double)
    allow(influx_client_double).to receive(:write_point)
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
        values: { value: value },
        tags: { location: location_name },
        timestamp: timestamp,
      }
      expect(influx_client_double).to receive(:write_point).with(expected_name, expected_data)
      subject
    end
  end
end
