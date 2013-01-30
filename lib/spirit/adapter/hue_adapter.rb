class Adapter::HueAdapter < Adapter::Base

  creator "Nick Rowe"
  adapts_to "Philips Hue Lighting System"
  website "http://github.com/nixterrimus/hue-spirit-adapter"

  implements :light

  requires_setup true

  settings do
    ip_address :adapter_address, required: true, description: "The network address of the white puck-shaped hue base station."
    string :base_station_nickname
    number :fade_time, description: "Fade time in milliseconds"
  end

  def initialize
  end

  def apply_device_state(device)
    nil
  end

  def update_device_state(device)
    nil
  end

  private

end
