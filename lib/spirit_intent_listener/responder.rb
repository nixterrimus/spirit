# A responder takes the channel and params and gets an instance
#   of the correct intent.  It can then apply the intent with
#   the appropriate parameters 
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
    channel.split(".").last.classify
  end

  def intent_class
    Object.const_get("Intent").const_get(intent_class_name)
  end

  def intent
    @intent ||= intent_class.new
  end

  def apply
    intent.apply(parsed_params)
  end

end
