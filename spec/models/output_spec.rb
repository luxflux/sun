require 'rails_helper'

RSpec.describe Output, type: :model do
  it { is_expected.to have_many(:rules) }
end
