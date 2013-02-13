module Device::Abilities::Switchable
  extend ActiveSupport::Concern
  include Toy::Object

  included do
    attribute :binary_state, Symbol, :default => :off
    validates :binary_state, inclusion: { in: [:on, :off] }
  end
end
