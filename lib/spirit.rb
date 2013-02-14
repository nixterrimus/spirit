# External Dependencies
require 'moneta'
require 'toystore'

# Standard Library Dependencies
require 'securerandom'
require 'singleton'

#Internal Dependencies
require "spirit/version"
require "spirit/adapters"
require "spirit/devices"
require "spirit/presets"


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
    @devices ||= Devices.find_or_initialize(self.persistance)
  end

  def self.presets
    @presets ||= Presets.find_or_initialize(self.persistance)
  end

  def self.adapters
    @adapters ||= Adapters.find_or_initialize(self.persistance)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :persistance_store

    def initialize
      @persistance_store = Moneta.new(:Memory)
    end

    def persistance_store=(store)
      @persistance_store = store
      Device.adapter :memory, @persistance_store
      Adapter::Base.adapter :memory, @persistance_store      
    end
  end
end
