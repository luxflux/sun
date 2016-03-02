require 'spec_helper'

RSpec.describe DataQueries::LastHours do
  let(:name) { 'temperature' }
  let(:hours) { 26 }
  let(:instance) { DataQueries::LastHours.new(name, hours) }

  describe '.call' do
    it 'creates a new instance and calls #call' do
      last_hours_double = instance_double(DataQueries::LastHours)
      expect(DataQueries::LastHours).to receive(:new).with(name, hours).and_return(last_hours_double)
      expect(last_hours_double).to receive(:call)
      DataQueries::LastHours.call(name, hours)
    end
  end

  describe '#call' do
    let(:response) do
      [
        {
          'value' => 1.2,
          'timeframe' => {
            'start' => '2016-03-01T18:00:00.000Z',
            'end' => '2016-03-01T18:01:00.000Z'
          }
        },
        {
          'value' => 2.1,
          'timeframe' => {
            'start' => '2016-03-01T18:01:00.000Z',
            'end' => '2016-03-01T18:02:00.000Z'
          }
        },
      ]
    end

    before do
      allow(Keen).to receive(:average).and_return(response)
    end

    it 'maps the response' do
      expected_response = [
        { time: '2016-03-01T18:00:00.000Z', mean: 1.2 },
        { time: '2016-03-01T18:01:00.000Z', mean: 2.1 },
      ]
      expect(instance.call).to eq(expected_response)
    end

    it 'queries for the given hours' do
      params = {
        target_property: 'value',
        timeframe: 'this_26_hours',
        interval: 'minutely',
      }
      expect(Keen).to receive(:average).with(name, params).and_return(response)
      instance.call
    end
  end
end
