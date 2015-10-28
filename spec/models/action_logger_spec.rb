require 'rails_helper'

RSpec.describe ActionLogger do
  let(:instance) { ActionLogger.new }
  let(:location_name) { 'somewhere' }
  let!(:location) { FactoryGirl.create :location, name: location_name }
  let(:port_number) { 1 }
  let!(:port) { FactoryGirl.create :output, location: location }
  let(:state) { 'on' }

  describe '#work' do
    let(:message) do
      {
        'location' => location_name,
        'port' => port_number,
        'state' => state,
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
      specify { expect { subject }.to change(ActionLogEntry, :count).by(1) }
    end
  end
end
