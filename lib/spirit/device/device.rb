Dir[File.join(File.dirname(__FILE__), 'abilities', '*.rb')].each {|file| require file }

class Device
  include Toy::Store
  include Toy::Store::All
  include ActiveModel::Observing

  attribute :device_adapter_id, String, default: nil
  attribute :name, String, default: "Device"

  # How the adapter distinguishes this device from other devices
  #   it manages.  For example ip address, node number, unique id
  attribute :device_adapter_identifier, String, default: nil

  after_update :apply_state

  validate :device_uniqueness

  def device_uniqueness
    return if device_adapter_id.nil?
    pool = self.class.all.select do|check_device| 
      check_device.device_adapter_id == device_adapter_id && 
        check_device.device_adapter_identifier == device_adapter_identifier
    end
    if !persisted? && !pool.empty? 
      errors.add(:device_adapter_identifier, "device already exists")
    end
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

  def update_attributes(attributes)
    super(attributes)
    self.class.notify_observers(:after_update, self)
  end

  private

  def apply_state
    device_adapter_worker.perform!(id, device_adapter_id)
  end

  def device_adapter_worker
    SuckerPunch::Queue[:adapters]
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
require 'spirit/device/squeezebox'
