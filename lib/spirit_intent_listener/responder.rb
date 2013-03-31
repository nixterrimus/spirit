class Responder
  attr_reader :params, :parsed_params, :channel
  def initialize(channel, params)
    @params = params
    @channel = channel
    parse_params
  end

  def parse_params
    @parsed_params = JSON.parse(params).with_indifferent_access
  end

  def intent_class_name
    
  end

end
