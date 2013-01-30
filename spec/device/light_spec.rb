require 'spec_helper'
require 'identifiable_spec'
require 'device/ability/switchable_spec'

describe Device::Light do
  subject { Device::Light.new }

  it_should_behave_like Device::Abilities::Switchable, Device::Light.new
  it_should_behave_like Identifiable, Device::Light.new
end
