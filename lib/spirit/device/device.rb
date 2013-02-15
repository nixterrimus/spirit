Dir[File.join(File.dirname(__FILE__), 'abilities', '*.rb')].each {|file| require file }

class Device
  include Toy::Store

  attribute :device_adapter_id, String
  after_save :apply_state
  after_save :add_to_all_pool

  # Eventually need to be wrapped up to handle problems with talking
  #  to the real world (ie, begin resuce).  Don't want to assume that
  #  they are always going to work
  def apply_state
    device_adapter.apply_device_state(self)
  end

  def device_adapter
    @device_adapter || load_device_adapter
  end

  def device_adapter=(device_adapter)
    self.device_adapter_id = device_adapter.id
    @device_adapter = device_adapter
  end

  def get_updated_state
    adapter.update_device_state(self)
  end

  def abilities
    ability_modules.collect { |m| ability_module_to_s(m) }
  end

  def self.all_ids
    adapter.read(all_persistence_key)
  end

  def self.all_persistence_key
    'devices'
  end

  def self.all
    self.all_ids.collect { |id| self.read(id) }
  end

  private

  def add_to_all_pool
    known_ids = self.class.all_ids || []
    all = known_ids.push(self.id)
    adapter.write(self.class.all_persistence_key, all)
  end

  def load_device_adapter
    self.device_adapter = (Adapter::Base.read(device_adapter_id) || default_device_adapter)
  end

  def default_device_adapter
    Adapter::NilAdapter.new
  end

  def ability_modules
    self.class.included_modules.select { |m| ability_module?(m) }
  end

  def ability_module?(m)
    m.to_s =~ /Abilities/
  end

  def ability_module_to_s(m)
    m.to_s.downcase.split('::').last
  end
end

require 'spirit/device/light'
require 'spirit/device/colorable_light'
require 'spirit/device/dimmable_light'
