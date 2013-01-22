require 'spec_helper'

describe Device::DimmableLight do
  subject { Device::DimmableLight.new }

  it_should_behave_like Device::Abilities::Switchable, Device::DimmableLight.new
  it_should_behave_like Device::Abilities::Dimmable, Device::DimmableLight.new  
  it_should_behave_like Device::Abilities::Identifiable, Device::DimmableLight.new
  
end

