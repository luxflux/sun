FactoryGirl.define do
  factory :input do
    location
    type 'Input'
    number 1
    signal_type 'analog'
    sequence(:name) { |i| "Humidity #{i}" }
  end

  factory :output do
    location
    type 'Output'
    number 1
    signal_type 'analog'
    sequence(:name) { |i| "Relay #{i}" }
  end
end
