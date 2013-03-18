module Abilities
  module Switchable
    extend ActiveSupport::Concern

    included do
      attribute :binary_state, String, :default => 'off'
      validates :binary_state, inclusion: { in: ['on', 'off'] }
    end
  end
end
