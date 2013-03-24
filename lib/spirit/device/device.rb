Dir[File.join(File.dirname(__FILE__), 'abilities', '*.rb')].each {|file| require file }

class Device
  include Toy::Store
  include Toy::Store::All
  include ActiveModel::Observing

  attribute :driver_id, String, default: nil
  attribute :name, String, default: "Device"

  # How the adapter distinguishes this device from other devices
  #   it manages.  For example ip address, node number, unique id
  attribute :driver_identifier, String, default: nil

  after_update :apply_state

  validate :device_uniqueness

  def device_uniqueness
    return if driver_id.nil?
    pool = self.class.all.select do|check_device| 
      check_device.driver_id == driver_id && 
        check_device.driver_identifier == driver_identifier
    end
    if !persisted? && !pool.empty? 
      errors.add(:driver_identifier, "device already exists")
    end
  end

  def driver
    @driver ||= Driver::Base.read(driver_id)
  end

  def driver=(driver)
    @driver = driver
    self.driver_id = @driver.try(:id)
  end

  def abilities
    ability_modules.collect { |m| ability_module_to_s(m) }
  end

  def update_attributes(attributes)
    super(attributes)
    self.class.notify_observers(:after_update, self)
  end

  def current_state
    state = {}
    current_state_attributes.map { |attr| state[attr] = send(attr) }
    state
  end

  def current_state_attributes
    self.class.attributes.keys - Device.attributes.keys - current_state_black_listed_attributes 
  end
  
  private

  def current_state_black_listed_attributes
    ["type"]
  end

  def apply_state
    driver.apply(self)
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
