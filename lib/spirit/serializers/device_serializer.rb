class DeviceSerializer < ActiveModel::Serializer
  attributes :name, :id, :abilities, :state, :type

  def state
    object.current_state
  end
end
