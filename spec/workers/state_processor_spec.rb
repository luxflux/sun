require 'rails_helper'

RSpec.describe StateProcessor do
  let(:instance) { StateProcessor.new }
  let(:location_name) { 'somewhere' }
  let(:location) { FactoryGirl.create :location, name: location_name }
  let(:port_number) { 1 }
  let(:port) { FactoryGirl.create :input, location: location }
  let(:current) { 100 }
  let(:signal_type) { 'analog' }

  describe '#work' do
    let(:message) do
      {
        'location' => location_name,
        'port' => port_number,
        'type' => signal_type,
        'value' => current,
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

    context 'location does not exist' do
      specify { expect { subject }.to change(Location, :count).by(1) }
    end

    context 'location exists' do
      before do
        location.save
      end

      specify { expect { subject }.to_not change(Location, :count) }
    end

    context 'input does not exist' do
      specify { expect { subject }.to change(Input, :count).by(1) }

      it 'assigns the correct values' do
        subject
        expect(Input.last.name).to eq("Port ##{port_number}")
        expect(Input.last.signal_type).to eq(signal_type)
      end
    end

    context 'input exists' do
      before do
        FactoryGirl.create :input, location: location, number: port_number
      end

      specify { expect { subject }.to_not change(Input, :count) }
    end

    context 'metric does not exist' do
      specify { expect { subject }.to change(Metric, :count).by(1) }

      it 'assigns the current value' do
        subject
        expect(Metric.last.current).to eq(current)
      end
    end

    context 'metric exists' do
      before do
        port.create_metric
      end

      specify { expect { subject }.to_not change(Metric, :count) }
      specify { expect { subject }.to change { port.metric.reload.current }.to(current) }
    end
  end
end
