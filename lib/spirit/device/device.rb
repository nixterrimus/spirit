Dir[File.join(File.dirname(__FILE__), 'abilities', '*.rb')].each {|file| require file }

class Device
  include Toy::Store

  attribute :device_adapter_id, String
  after_save :apply_state

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

  private

  def load_device_adapter
    self.device_adapter = (Adapter::Base.read(device_adapter_id) || default_adapter)
  end

  def default_adapter
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
