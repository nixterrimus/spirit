module Serializable
  def update_attributes(attributes = {})
    attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
  end

  def marshal_dump
    self.to_hash
  end

  def to_hash
    {}
  end

  def marshal_load attributes_hash
    self.update_attributes(attributes_hash)
  end

end
