class RulesDispatcher
  include Sneakers::Worker

  from_queue 'rules',
             routing_key: 'measurements.#',
             exchange: 'homeauto',
             exchange_type: :topic,
             durable: true

  attr_reader :message

  def work(json)
    @message = InputMessage.new(json)
    Sneakers.logger.info "RuleDispatcher: #{message}"

    input.rules.each do |rule|
      if rule.matches?(message.value)
        Sneakers.logger.info "#{rule} matched"
        RuleProcessor.call(rule)
      else
        Sneakers.logger.debug "#{rule} did not match"
      end
    end

    ack!
  end

  def input
    @input ||= location.inputs.find_by_number!(message.port_number)
  end

  def location
    @location ||= Location.find_by_name!(message.location_name)
  end
end
