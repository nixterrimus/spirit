# External Dependencies
require 'moneta'
require 'toystore'
require 'sucker_punch'
require 'redis'

# Standard Library Dependencies
require 'singleton'

#Internal Dependencies
require 'spirit/workers/adapter'
require "spirit/version"
require "spirit/all"
require "spirit/adapter/base"
require "spirit/preset"
require "spirit/triggers/event"
require "spirit/triggers/action"
require "spirit/triggers/preset_action"
require "spirit/triggers/event_listener"
require "spirit/triggers/trigger"
require 'spirit/device/device'


module Spirit
  class << self
    attr_accessor :configuration, :devices, :adapters
  end

  def self.configure
    configuration = self.configuration
    yield(configuration) if block_given?
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
      @persistance_store = Moneta.new(:File, dir: "./persistence")

      SuckerPunch.config do
        queue name: :adapters, worker: ::Worker::AdapterWorker, size: 2
      end

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
      [Device, Light, Preset, DimmableLight, ColorableLight] + persisted_adapters
    end

    def persisted_adapters
      adapters = Adapter.constants.select {|c| Adapter.const_get(c).is_a?(Class) && Adapter.const_get(c).respond_to?('adapter') }
      adapters.collect { |c| Adapter.const_get(c) }
    end
  end
end

Spirit.configure
