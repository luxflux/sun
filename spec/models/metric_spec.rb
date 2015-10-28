require 'rails_helper'

RSpec.describe Metric, type: :model do
  it { is_expected.to belong_to(:port) }
  it { is_expected.to validate_presence_of(:port) }
end
