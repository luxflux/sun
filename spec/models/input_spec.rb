require 'rails_helper'

RSpec.describe Input, type: :model do
  it { is_expected.to have_one(:metric) }
end
