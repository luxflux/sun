class InfluxQueries::LastHours
  attr_reader :name, :hours

  def self.call(name, hours)
    new(name, hours).call
  end

  def initialize(name, hours)
    @name = name
    @hours = hours
  end

  def call
    response.map do |result|
      result['values']
    end.flatten
  end

  def response
    influxdb.query query
  end

  def query
    "SELECT mean(value) FROM #{name} WHERE time > now() - #{hours}h GROUP BY time(5m)"
  end

  def influxdb
    @influxdb ||= InfluxDB::Client.new Global.influxdb.database
  end
end
