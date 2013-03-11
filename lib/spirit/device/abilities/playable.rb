module Abilities
  module Playable
    extend ActiveSupport::Concern

    included do
      attribute :play_state, Symbol, default: :stopped
      validates :play_state, inclusion: { in: [:playing, :stopped, :paused] }
    end
  end
end
