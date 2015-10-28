class Metric < ActiveRecord::Base
  belongs_to :port

  validates :port, presence: true

  def last_hours(hours)
    InfluxQueries::LastHours.call(name, hours)
  end

  def name
    "#{port.location.name}.port-#{port.number}"
  end
end
