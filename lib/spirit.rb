# External Dependencies
require 'moneta'
require 'toystore'
require 'redis'
require 'active_model_serializers'

#Internal Dependencies
require "spirit/version"
require "spirit/all"
require "spirit/driver/base"
require "spirit/preset"
require "spirit/triggers/event"
require 'spirit/triggers/event_bus'
require 'spirit/device/device'

require 'spirit/serializers/device_serializer'
require 'spirit/serializers/preset_serializer'
require 'spirit/serializers/driver_serializer'

require 'spirit/observers/device_events'
require 'spirit/observers/preset_events'

require 'spirit/environment'

module Spirit
  class << self
    attr_accessor :configuration, :devices, :drivers
  end

  def self.configure
    configuration = self.configuration
    yield(configuration) if block_given?
  end

  def self.environment
    @environment ||= Environment.new
  end

  def self.devices
    Device.all
  end

  def self.presets
    Preset.all
  end

  def self.drivers
    Driver::Base.all
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :persistance_store

    def initialize
      @persistance_store = Moneta.new(:File, dir: "./persistence")

      update_drivers
    end

    def persistance_store=(store)
      @persistance_store = store
      update_drivers
    end

    private

    def update_drivers
     persisted_classes.each { |c| c.adapter :memory, @persistance_store }
    end

    def persisted_classes
      # TODO: Do better than just listing these out, find this list
      #   programmatically
      [Device, Light, Preset, DimmableLight, ColorableLight] + persisted_drivers
    end

    def persisted_drivers
      drivers = Driver.constants.select {|c| Driver.const_get(c).is_a?(Class) && Driver.const_get(c).respond_to?('driver') }
      drivers.collect { |c| Driver.const_get(c) }
    end
  end
end

Spirit.configure
