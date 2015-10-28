require 'spec_helper'

RSpec.describe ActionMessage do
  let(:instance) { ActionMessage.new(json) }
  let(:location) { 'abc' }
  let(:port) { 1 }
  let(:state) { 'on' }
  let(:json) do
    {
      location: location,
      port: port,
      state: state,
    }.to_json
  end

  describe '#location_name' do
    subject { instance.location_name }
    it { is_expected.to eq(location) }
  end

  describe '#port_number' do
    subject { instance.port_number }
    it { is_expected.to eq(port) }
  end

  describe '#state' do
    subject { instance.state }
    it { is_expected.to eq(state) }
  end
end
