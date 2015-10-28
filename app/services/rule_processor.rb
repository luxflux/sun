class RuleProcessor
  def self.call(rule)
    new(rule).call
  end

  attr_reader :rule

  def initialize(rule)
    @rule = rule
  end

  def call
    publisher.publish(message, to_queue: queue)
    true
  end

  def publisher
    @publisher ||= Sneakers::Publisher.new exchange: Global.amqp.exchange,
                                           exchange_type: Global.amqp.exchange_type
  end

  def message
    JSON.dump(location: location_name, port: port_number, state: rule.state)
  end

  def queue
    "actions.#{location_name}.port-#{port_number}"
  end

  def location_name
    rule.output.location.name
  end

  def port_number
    rule.output.number
  end
end
