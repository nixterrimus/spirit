require 'dino'

class Adapter::ArduinoAdapter < Adapter::Base

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
    #@board = Dino::Board.new(Dino::TxRx.new)
    #@led = Dino::Components::Led.new(pin: 13, board: @board)
  end

  def apply_device_state(device)
    if device.on?
      @led.send(:on)
    elsif device.off?
      @led.send(:off)
    end
  end

  def update_device_state(device)
    nil
  end

end
