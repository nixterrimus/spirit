class Adapter::HueAdapter < Adapter::Base

  creator "Nick Rowe"
  adapts_to "Philips Hue Lighting System"
  website "http://github.com/nixterrimus/hue-spirit-adapter"

  implements :colorable_light

  requires_setup true

  settings do
    ip_address :adapter_address, required: true, description: "The network address of the white puck-shaped hue base station."
    string :base_station_name
    number :fade_time, description: "Fade time in milliseconds"
  end

  def apply_device_state(device)
    hue.all_lights.write light_attributes(device)
  end

  def update_device_state(device)
    nil
  end

  private

  def hue
    @hue ||= Hue::Hue.new(ip: adapter_address)
  end

  def light_attributes(device)
    {
      on: device.binary_state,
      bri: hue_brightness(device),
      hue: hue_hue(device),
      sat: hue_saturation(device),
    }
  end

  def hue_brightness(device)
    (device.brightness * 2.55).floor
  end

  def hue_hue(device)
    40000
  end

  def hue_saturation(device)
    200
  end

end
