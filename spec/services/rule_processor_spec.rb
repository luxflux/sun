require 'rails_helper'

RSpec.describe RuleProcessor do
  let(:rule) { FactoryGirl.create :rule }

  describe '.call' do
    subject { RuleProcessor.call(rule) }

    it { is_expected.to eq(nil) }
  end
end
