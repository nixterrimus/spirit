module Identifiable
  def uuid
    @uuid || generate_uuid
  end

  def uuid=(identifier)
    @uuid = identifier
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
