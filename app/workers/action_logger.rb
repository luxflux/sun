class ActionLogger
  include Sneakers::Worker

  from_queue 'logs',
             routing_key: 'actions.#',
             exchange: Global.amqp.exchange,
             exchange_type: Global.amqp.exchange_type,
             durable: true

  attr_reader :message

  def work(json)
    @message = ActionMessage.new(json)
    Sneakers.logger.info "ActionLogger: #{message}"

    ActionLogEntry.create! port: port, state: state

    ack!
  end

  def location
    @location ||= Location.find_by_name!(message.location_name)
  end

  def port
    @port ||= location.ports.find_by_number!(message.port_number)
  end

  def state
    message.state
  end
end
