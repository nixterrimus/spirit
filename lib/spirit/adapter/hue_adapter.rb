require 'huey'

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

  def apply(attributes)
    bulb = light_for(attributes)
    bulb.rgb = hex_color(attributes)
    bulb.bri = brightness(attributes)
    bulb.on = on?(attributes)
    bulb.commit
  end

  def update_device_state(device)
    nil
  end

  private

  def light_for(attributes)
    # Eventually look up the bulb based on id
    Huey::Bulb.find(12)
  end

  def on?(attributes)
    attributes["binary_state"] == :on
  end

  def brightness(attributes)
    (attributes["level"] * 2.55).floor
  end

  def hex_color(attributes)
    red = (attributes["red_level"] * 2.55).floor
    green = (attributes["green_level"] * 2.55).floor
    blue = (attributes["blue_level"] * 2.55).floor

    "#%02X%02X%02X" % [red, green, blue]
  end

end
