require 'spec_helper'
require 'spirit/identifiable_spec'
require 'spirit/device/ability/switchable_spec'
require 'spirit/device/ability/dimmable_spec'

describe Device::DimmableLight do
  subject { Device::DimmableLight.new }

  it_should_behave_like Device::Abilities::Switchable, Device::DimmableLight.new
  it_should_behave_like Device::Abilities::Dimmable, Device::DimmableLight.new  
  it_should_behave_like ::Identifiable, Device::DimmableLight.new
  
end

