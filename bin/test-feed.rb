require 'sneakers'
require 'sneakers/publisher'
require 'json'

Sneakers.configure logger: ::Logger.new(STDOUT)

Sneakers.logger.level = ::Logger::INFO

publisher = Sneakers::Publisher.new exchange: 'homeauto', exchange_type: :topic

loop do
  [
    { location: 'test', port: 1, type: :digital, value: [0, 1].sample, timestamp: Time.now.to_i },
    { location: 'test', port: 2, type: :digital, value: Kernel.rand(100), timestamp: Time.now.to_i },
    { location: 'test', port: 10, type: :analog, value: Kernel.rand(20..33), timestamp: Time.now.to_i },
  ].each do |message|
    publisher.publish(JSON.dump(message), to_queue: "measurements.#{message[:location]}.port-#{message[:port]}")
  end

  sleep 1
end
