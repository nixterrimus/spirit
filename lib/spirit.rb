# External Dependencies
require 'moneta'

# Standard Library Dependencies
require 'securerandom'
require 'singleton'

#Internal Dependencies
require "spirit/version"
require "spirit/persistance"
require "spirit/adapter"
require "spirit/adapters"
require "spirit/device"
require "spirit/devices"


class ObjectStore

  attr_accessor :persistance_store

  def initialize(persistance_store)
    @persistance_store = persistance_store
    @cached_objects = {}
  end

  def save(object)
    persistance_store.store(object.persistance_key, Marshal.dump(object))
  end

  def load(key)
     @cached_objects[key] || load_and_cache(key)
  end

  def stored?(key)
    persistance_store.key? key
  end

  private

  def cache_object(key, value)
    @cached_objects[key] = value
  end

  def load_and_cache(key)
    device_dump = persistance_store.fetch(key)
    loaded_object = Marshal.load(device_dump)
    cache_object(key, loaded_object)
    return loaded_object
  end
end

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
    @devices ||= Devices.find_or_initialize_in(self.persistance)
  end

  def self.adapters
    @adapters ||= Adapters.find_or_initialize_in(self.persistance)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :persistance_store

    def initialize
      @persistance_store = Moneta.new(:Memory)
    end
  end
end
