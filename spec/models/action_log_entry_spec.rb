require 'rails_helper'

RSpec.describe ActionLogEntry, type: :model do
  it { is_expected.to belong_to(:port) }
  it { is_expected.to validate_presence_of(:port) }
  it { is_expected.to validate_presence_of(:state) }
end
