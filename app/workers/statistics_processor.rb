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
    values = {}
    values[:value] = message['value']
    data = {
      values: values,
      tags: { location: message['location'] },
      timestamp: message['timestamp'],
    }
    Sneakers.logger.info "Writing #{data}"
    influxdb.write_point "#{message['location']}.port-#{message['port']}", data
    ack!
  end

  def influxdb
    @influxdb ||= InfluxDB::Client.new Global.influxdb.database
  end
end
