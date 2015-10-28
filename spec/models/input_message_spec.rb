require 'spec_helper'

RSpec.describe InputMessage do
  let(:instance) { InputMessage.new(json) }
  let(:location) { 'abc' }
  let(:port) { 1 }
  let(:type) { 'analog' }
  let(:value) { 100 }
  let(:timestamp) { Time.now.to_i }
  let(:json) do
    {
      location: location,
      port: port,
      type: type,
      value: value,
      timestamp: timestamp,
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

  describe '#signal_type' do
    subject { instance.signal_type }
    it { is_expected.to eq(type) }
  end

  describe '#value' do
    subject { instance.value }
    it { is_expected.to eq(value) }
  end

  describe '#timestamp' do
    subject { instance.timestamp }
    it { is_expected.to eq(timestamp) }
  end
end
