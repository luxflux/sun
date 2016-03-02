class DataQueries::LastHours
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
      {
        time: result['timeframe']['start'],
        mean: result['value'],
      }
    end
  end

  def response
    Keen.average(name, target_property: 'value', timeframe: "this_#{hours}_hours", interval: 'minutely')
  end
end
