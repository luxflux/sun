class Rule < ActiveRecord::Base
  belongs_to :input
  belongs_to :output

  enum rule: %i(higher lower equal)
  enum state: %i(on off)

  validates :input, presence: true
  validates :output, presence: true
  validates :rule, presence: true
  validates :threshold, presence: true
  validates :state, presence: true
end
