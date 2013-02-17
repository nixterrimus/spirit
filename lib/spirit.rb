# External Dependencies
require 'moneta'
require 'toystore'

# Standard Library Dependencies
require 'singleton'

#Internal Dependencies
require "spirit/version"
require "spirit/all"
require "spirit/adapters"
require "spirit/preset"
require 'spirit/device/device'


module Spirit
  class << self
    attr_accessor :configuration, :devices, :adapters
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.persistance
    @persistance ||= ObjectStore.new(self.configuration.persistance_store)
  end

  def self.devices
    Device.all
  end

  def self.presets
    Preset.all
  end

  def self.adapters
    Adapter.all
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :persistance_store

    def initialize
      @persistance_store = Moneta.new(:Memory)
      update_adapters
    end

    def persistance_store=(store)
      @persistance_store = store
      update_adapters
    end

    private

    def update_adapters
     persisted_classes.each { |c| c.adapter :memory, @persistance_store }
    end

    def persisted_classes
      # TODO: Do better than just listing these out, find this list
      #   programmatically
      [Device, Light, Preset, DimmableLight, ColorableLight, Adapter::Base]
    end
  end
end
