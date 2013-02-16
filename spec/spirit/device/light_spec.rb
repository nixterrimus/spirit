require 'spec_helper'
require 'spirit/device/ability/switchable_spec'

describe Light do
  subject { Device::Light.new }

  it_should_behave_like Abilities::Switchable, Light.new
end
