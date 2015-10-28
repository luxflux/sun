FactoryGirl.define do
  factory :rule do
    input
    rule 'higher'
    threshold 100
    output
    state 'on'
  end
end
