require 'spec_helper'
require 'identifiable_spec'
require 'device/ability/switchable_spec'
require 'device/ability/dimmable_spec'

describe Device::DimmableLight do
  subject { Device::DimmableLight.new }

  it_should_behave_like Device::Abilities::Switchable, Device::DimmableLight.new
  it_should_behave_like Device::Abilities::Dimmable, Device::DimmableLight.new  
  it_should_behave_like ::Identifiable, Device::DimmableLight.new
  
end

