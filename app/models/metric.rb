class Metric < ActiveRecord::Base
  belongs_to :input

  validates :input, presence: true

  def last_hours(hours)
    InfluxQueries::LastHours.call(name, hours)
  end

  def name
    "#{input.location.name}.port-#{input.number}"
  end
end
