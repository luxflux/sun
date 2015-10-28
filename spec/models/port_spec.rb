require 'rails_helper'

RSpec.describe Port, type: :model do
  it { is_expected.to belong_to(:location) }
  it { is_expected.to have_many(:action_log_entries) }

  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:signal_type) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to define_enum_for(:signal_type).with(%i(analog digital)) }
end
