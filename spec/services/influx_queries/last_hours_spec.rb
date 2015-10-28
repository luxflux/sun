require 'spec_helper'

RSpec.describe InfluxQueries::LastHours do
  let(:name) { 'temperature' }
  let(:hours) { 26 }
  let(:instance) { InfluxQueries::LastHours.new(name, hours) }

  describe '.call' do
    it 'creates a new instance and calls #call' do
      last_hours_double = instance_double(InfluxQueries::LastHours)
      expect(InfluxQueries::LastHours).to receive(:new).with(name, hours).and_return(last_hours_double)
      expect(last_hours_double).to receive(:call)
      InfluxQueries::LastHours.call(name, hours)
    end
  end

  describe '#call' do
    let(:response) do
      [
        'values' => [
          { 'time' => '2015-09-11T18:05:00Z', 'mean' => 1.2 },
          { 'time' => '2015-09-11T18:15:00Z', 'mean' => 2.1 },
        ]
      ]
    end

    let(:influxdb_double) { instance_double(InfluxDB::Client) }

    before do
      allow(InfluxDB::Client).to receive(:new).and_return(influxdb_double)
      allow(influxdb_double).to receive(:query).and_return(response)
    end

    it 'maps the response' do
      expected_response = [
        { 'time' => '2015-09-11T18:05:00Z', 'mean' => 1.2 },
        { 'time' => '2015-09-11T18:15:00Z', 'mean' => 2.1 },
      ]
      expect(instance.call).to eq(expected_response)
    end

    it 'queries for the given hours' do
      expected_query = 'SELECT mean(value) FROM "temperature" WHERE time > now() - 26h GROUP BY time(5m)'
      expect(influxdb_double).to receive(:query).with(expected_query)
      instance.call
    end
  end
end
