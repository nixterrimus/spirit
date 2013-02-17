module Abilities
  module Colorable
    extend ActiveSupport::Concern

    included do
      attribute :red_level, Integer, :default => 0
      validates :red_level, :inclusion => 0..100

      attribute :green_level, Integer, :default => 0
      validates :green_level, :inclusion => 0..100

      attribute :blue_level, Integer, :default => 0
      validates :blue_level, :inclusion => 0..100
    end
  end
end

