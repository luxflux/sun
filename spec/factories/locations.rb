FactoryGirl.define do
  factory :location do
    sequence(:name) { |i| "Somewhere #{i}" }
  end
end
