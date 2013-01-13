require 'pry'

# An adapter is a piece of code that is capable of translating virtual state
#   into physical state.
# Trying to steal ideas from Faraday (an HTTP adapter)
module Adapter

  # The most basic possible adapter, for all calls it logs them
  class LogAdapter
    def method_missing(meth, *args, &block)
      puts "Log Adapter: Called #{meth} with args #{args}"
    end
  end


  # An HTTP adapter for talking to the hue bridge
  #   There might be a whole class of adapter that talk to HTTP - include a
  #   HTTP base class?
  class HueAdapter

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
  class ArduinoAdapter
    # require 'serialport'
    def initialize(serial_port, baud, parity)
      # serial port setup
    end

    def on(device)
      # use the already setup serial port to send some data
      puts "#{device.class} sending ON"
    end

    def off(device)
      # use the already setup serial port to send some data
      puts "#{device.class} sending OFF"
    end
  end
end




# A device is an object that maintains state;
# The UI will show a list of devices
class Device
  # Every device should have a setting variable that is persisted
  def initialize(adapter = nil)
    @adapter = adapter || Adapter::LogAdapter.new
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


# This with a motor: http://www.runnerduck.com/images/kc_pinwheel.jpg
class MotorizedWhirlyPod < Device
  include Capabilities::BinaryDevice
end




hue_adapter = Adapter::HueAdapter.new('0.0.0.0')
arduino_adapter = Adapter::ArduinoAdapter.new(1, 9600, 1)

devices = Array.new
devices <<  HueBulb.new(hue_adapter, 1)
devices <<  HueBulb.new(hue_adapter, 2)
devices <<  MotorizedWhirlyPod.new(arduino_adapter)



binding.pry

