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

  def matches?(value)
    case rule.to_sym
    when :higher
      value > threshold
    when :equal
      value == threshold
    when :lower
      value < threshold
    end
  end
end
