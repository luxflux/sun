class StatisticsProcessor
  include Sneakers::Worker

  from_queue 'statistics',
             routing_key: 'measurements.#',
             exchange: 'homeauto',
             exchange_type: :topic,
             durable: true

  def work(message)
    message = JSON.parse(message)
    Sneakers.logger.info "Statistics: #{message}"
    data = {
      location: message['location'],
      port: message['port'],
      value: message['value'],
      keen: { timestamp: Time.at(message['timestamp']).iso8601 },
    }
    Sneakers.logger.info "Writing #{data}"
    Keen.publish "#{message['location']}.port-#{message['port']}", data
    ack!
  end
end
