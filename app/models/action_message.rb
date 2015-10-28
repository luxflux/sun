ActionMessage = Struct.new(:location_name, :port_number, :state) do
  def initialize(json)
    message = JSON.parse(json)
    self.location_name = message['location']
    self.port_number = message['port']
    self.state = message['state']
  end
end
