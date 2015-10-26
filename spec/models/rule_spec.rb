require 'rails_helper'

RSpec.describe Rule, type: :model do
  it { is_expected.to validate_presence_of(:input) }
  it { is_expected.to validate_presence_of(:output) }
  it { is_expected.to validate_presence_of(:rule) }
  it { is_expected.to validate_presence_of(:threshold) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to define_enum_for(:rule).with(%i(higher lower equal)) }
  it { is_expected.to define_enum_for(:state).with(%i(on off)) }
end
