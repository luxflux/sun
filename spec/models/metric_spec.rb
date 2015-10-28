require 'rails_helper'

RSpec.describe Metric, type: :model do
  it { is_expected.to belong_to(:input) }
  it { is_expected.to validate_presence_of(:input) }
end
