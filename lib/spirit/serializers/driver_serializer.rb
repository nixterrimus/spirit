class DriverSerializer  < ActiveModel::Serializer
  attributes :id, :metadata

  def metadata
    {
      creator_name: object.class.creator,
      adapts_to: object.class.adapts_to
    }
  end
end
