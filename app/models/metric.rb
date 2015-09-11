class Metric < ActiveRecord::Base
  belongs_to :location

  validates :name, :location, presence: true
  validates :name, uniqueness: true

  def last_hours(hours)
    InfluxQueries::LastHours.call(name, hours)
  end
end
