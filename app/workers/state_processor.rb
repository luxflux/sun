class StateProcessor
  include Sneakers::Worker

  from_queue 'state',
             routing_key: 'measurements.#',
             exchange: 'homeauto',
             exchange_type: :topic,
             durable: true

  def work(message)
    message = JSON.parse(message)
    Sneakers.logger.info "State update: #{message}"
    location_name = message['location']
    port = message['port']
    signal_type = message['type']
    value = message['value']

    Sneakers.logger.info "Ensure location #{location_name} exists"
    location = Location.where(name: location_name).first_or_create!

    Sneakers.logger.info "Ensure #{location_name}/#{port} exists"
    port = location.inputs.where(number: port).first_or_create!(signal_type: signal_type, type: 'Input', name: "Port ##{port}")
    Sneakers.logger.info "Update current value of #{location_name}/#{port} to #{value}"
    metric = port.metric || port.build_metric
    metric.current = value
    metric.save!

    ack!
  end
end
