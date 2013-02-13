module Device::Abilities::Dimmable
  extend ActiveSupport::Concern
  include Toy::Object

  included do
    attribute :level, Integer, :default => 0
    validates :level, :inclusion => 0..100
  end
end
