FactoryGirl.define do
  factory :metric do
    location
    name 'temperature'
    current 1.5
  end
end
