require 'spec_helper'

describe Device::Light do
  subject { Device::Light.new }

  it_should_behave_like Capability::Switchable, Device::Light.new

  describe 'play' do
    adapter = Adapter::Arduino.new
    light = Device::Light.new(adapter)
    binding.pry
  end

end
