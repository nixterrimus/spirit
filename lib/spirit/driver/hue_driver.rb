require 'huey'

class Driver::HueAdapter < Driver::Base

  creator "Nick Rowe"
  adapts_to "Philips Hue Lighting System"
  website "http://github.com/nixterrimus/hue-spirit-adapter"

  implements :colorable_light

  requires_setup true
  user_can_manually_add_devices false

  settings do
    ip_address :adapter_address, required: true, description: "The network address of the white puck-shaped hue base station."
    string :base_station_name
    number :fade_time, description: "Fade time in milliseconds"
  end

  setup do
    step(:find_base_station) do
      # Things to find base station
      true # when base station is found
    end
    step(:ask_user_to_press_button) do
      true # when button has been pressed
    end
    step(:settings) # A special step that shows a settings page based on settings defined above
  end

  def apply(device)
    attributes = device.attributes
    bulb = light_for(attributes)
    bulb.on = on?(attributes)

    if on?(attributes)
      bulb.rgb = hex_color(attributes)
      bulb.bri = brightness(attributes)
    end

    bulb.commit
  end

  def poll(device)
    bulb = light_for(attributes)
    attributes = {
      binary_state: bulb.on ? :on : :off
    }
    device.update_attributes(attributes)
  end

  def discover
    Huey::Bulb.all.each { |b| ColorableLight.create( driver_id: self.id, driver_identifier: b.id, name: b.name) }
  end

  private

  def light_for(attributes)
    id = attributes["driver_identifier"]
    Huey::Bulb.find(id.to_i)
  end

  def on?(attributes)
    attributes["binary_state"] == 'on'
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
