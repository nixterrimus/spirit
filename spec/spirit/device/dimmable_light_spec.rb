require 'spec_helper'
require 'spirit/device/ability/switchable_spec'
require 'spirit/device/ability/dimmable_spec'

describe DimmableLight do
  subject { Device::DimmableLight.new }

  it_should_behave_like Abilities::Switchable, DimmableLight.new
  it_should_behave_like Abilities::Dimmable, DimmableLight.new  
  
end

