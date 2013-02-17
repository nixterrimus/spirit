module Abilities
  module Dimmable
    extend ActiveSupport::Concern

    included do
      attribute :level, Integer, :default => 0
      validates :level, :inclusion => 0..100
    end
  end
end
