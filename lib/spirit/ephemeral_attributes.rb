module EphemeralAttributes
  def ephemeral_attribute(*names)
    ephemeral_attributes.concat(names)
  end

  def ephemeral_attributes
    @stored_ephemeral_attributes ||= [ ]
  end
end
