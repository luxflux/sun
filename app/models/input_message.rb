InputMessage = Struct.new(:location_name, :port_number, :signal_type, :value, :timestamp) do
  def initialize(json)
    message = JSON.parse(json)
    self.location_name = message['location']
    self.port_number = message['port']
    self.signal_type = message['type']
    self.value = message['value']
    self.timestamp = message['timestamp']
  end
end
