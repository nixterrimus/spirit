require 'spec_helper'

describe Device::Light do
  subject { Device::Light.new }

  it_should_behave_like Device::Abilities::Switchable, Device::Light.new
  it_should_behave_like Device::Abilities::Identifiable, Device::Light.new
end
