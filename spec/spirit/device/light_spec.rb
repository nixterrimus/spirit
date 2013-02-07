require 'spec_helper'
require 'spirit/identifiable_spec'
require 'spirit/device/ability/switchable_spec'

describe Device::Light do
  subject { Device::Light.new }

  it_should_behave_like Device::Abilities::Switchable, Device::Light.new
  it_should_behave_like Identifiable, Device::Light.new
end
