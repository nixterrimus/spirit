require 'pry'

# An adapter is a piece of code that is capable of translating virtual state
#   into physical state.  It also manages a set of devices.
# Trying to steal ideas from Faraday (an HTTP adapter)
module Adapter

  class Base
    attr_accessor :devices

    def register_device(device)
      @devices ||= []
      @devices << device
    end
  end

  # The most basic possible adapter, for all calls it logs them
  class LogAdapter < Adapter::Base
    def method_missing(meth, *args, &block)
      puts "Log Adapter: Called #{meth} with args #{args}"
    end
  end


  # An HTTP adapter for talking to the hue bridge
  #   There might be a whole class of adapter that talk to HTTP - include a
  #   HTTP base class?
  class HueAdapter < Adapter::Base

    attr_accessor :ip_address

    def initialize(ip_address)
      @ip_address = ip_address
    end

    def on(bulb)
      # use bulb state information to send the right http command to the ip_address
      puts "Bulb: #{bulb.bulb_id} - Sending ON HTTP command to #{ip_address}"
    end

    def off(bulb)
      # use bulb state information to send the right http command to the ip_address
      puts "Bulb: #{bulb.bulb_id} - Sending OFF HTTP command to #{ip_address}"
    end
  end


  # A serial adapter for talking to an ardunion - again base Serial class?
  class ArduinoAdapter < Adapter::Base
    require 'dino'
    def initialize(pin)
      board = Dino::Board.new(Dino::TxRx.new)
      @led = Dino::Components::Led.new(pin: pin, board: board)
    end

    def on(device)
      @led.send(:on)
    end

    def off(device)
      @led.send(:off)
    end
  end
end




# A device is an object that maintains state;
# The UI will show a list of devices.  Devices register themselves
# with the adapter
#
class Device
  attr_accessor :uid

  def initialize(adapter = nil)
    @adapter = adapter || Adapter::LogAdapter.new
    @adapter.register_device self
  end
end


# Mixins, These are things that a device can be and do
module Capabilities
  module BinaryDevice

    @binary_state = :off

    def on?
      @binary_state == :on
    end

    def off?
      @binary_state == :off
    end

    def on
      @binary_state = :on
      @adapter.on(self)
    end

    def off
      @binary_state = :off
      @adapter.off(self)
    end

    def toggle
      on? ? off : on
    end
    # All of this feels very basic, it's also possible to change multiple attributes
    #  at once.  In the adapter it's just one HTTP call to change level and turn the device
    #  on.  Maybe something like methods like: on!, off!, toggle! and commit would help.
  end

  module DimmableDevice
    @level = 0
  end
end


class HueBulb < Device
  include Capabilities::BinaryDevice
  include Capabilities::DimmableDevice

  attr_accessor :bulb_id

  def initialize(adapter, bulb_id)
    super(adapter)
    @bulb_id = bulb_id
  end
end


# Something like this: https://raw.github.com/austinbv/dino/master/examples/led/led.png
class BlinkyBlinky < Device
  include Capabilities::BinaryDevice
end




hue_adapter = Adapter::HueAdapter.new('0.0.0.0')
arduino_adapter = Adapter::ArduinoAdapter.new(13)

devices = Array.new
devices <<  HueBulb.new(hue_adapter, 1)
devices <<  HueBulb.new(hue_adapter, 2)
blinky =  BlinkyBlinky.new(arduino_adapter)
devices << blinky



binding.pry

