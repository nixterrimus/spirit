class Environment
  include Toy::Store
  
  attribute :name, String, default: 'Home'

  def devices
    Device.all
  end

  def drivers
    Driver::Base.all
  end

  def presets
    Preset.all
  end
end
