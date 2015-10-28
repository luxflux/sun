require 'rails_helper'

RSpec.describe Rule, type: :model do
  it { is_expected.to validate_presence_of(:input) }
  it { is_expected.to validate_presence_of(:output) }
  it { is_expected.to validate_presence_of(:rule) }
  it { is_expected.to validate_presence_of(:threshold) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to define_enum_for(:rule).with(%i(higher lower equal)) }
  it { is_expected.to define_enum_for(:state).with(%i(on off)) }

  describe '#matches?' do
    let(:rule) { FactoryGirl.create :rule, rule: rule_value, threshold: threshold }
    subject { rule.matches?(value) }

    context 'higher 100' do
      let(:rule_value) { :higher }
      let(:threshold) { 100 }

      context 'value 0' do
        let(:value) { 0 }
        it { is_expected.to eq(false) }
      end

      context 'value 100' do
        let(:value) { 100 }
        it { is_expected.to eq(false) }
      end

      context 'value 200' do
        let(:value) { 200 }
        it { is_expected.to eq(true) }
      end
    end

    context 'equal 100' do
      let(:rule_value) { :equal }
      let(:threshold) { 100 }

      context 'value 0' do
        let(:value) { 0 }
        it { is_expected.to eq(false) }
      end

      context 'value 100' do
        let(:value) { 100 }
        it { is_expected.to eq(true) }
      end

      context 'value 200' do
        let(:value) { 200 }
        it { is_expected.to eq(false) }
      end
    end

    context 'lower 100' do
      let(:rule_value) { :lower }
      let(:threshold) { 100 }

      context 'value 0' do
        let(:value) { 0 }
        it { is_expected.to eq(true) }
      end

      context 'value 100' do
        let(:value) { 100 }
        it { is_expected.to eq(false) }
      end

      context 'value 200' do
        let(:value) { 200 }
        it { is_expected.to eq(false) }
      end
    end
  end
end
