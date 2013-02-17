module Abilities
  module Switchable
    extend ActiveSupport::Concern

    included do
      attribute :binary_state, Symbol, :default => :off
      validates :binary_state, inclusion: { in: [:on, :off] }
    end
  end
end
