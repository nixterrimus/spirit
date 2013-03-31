class Responder
  attr_reader :params, :parsed_params
  def initialize(params)
    @params = params
    parse_params
  end

  def parse_params
    @parsed_params = JSON.parse(params).with_indifferent_access
  end

end
