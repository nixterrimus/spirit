Dir[File.join(File.dirname(__FILE__), 'abilities', '*.rb')].each {|file| require file }

class Device
  include Toy::Store
  include Toy::Store::All

  attribute :device_adapter_id, String
  after_save :apply_state
  after_save :add_to_all_pool

  def apply_state
    #device_adapter.apply(self.attributes) unless device_adapter.nil?
    device_adapter.async.apply(self.attributes) unless device_adapter.nil?
  end

  def device_adapter
    @device_adapter ||= Adapter::Base.read(device_adapter_id)
  end

  def device_adapter=(device_adapter)
    @device_adapter = device_adapter
    self.device_adapter_id = @device_adapter.try(:id)
  end

  def abilities
    ability_modules.collect { |m| ability_module_to_s(m) }
  end

  private

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
