require 'spec_helper'

describe Device::Light do
  let(:adapter) { Adapter::NilAdapter.new }
  let(:subject) { Device::Light.new(adapter) }

  # This doesn't seem to work with subject and adapter... very frustrating
  it_should_behave_like Capability::BinaryDevice, Device::Light.new(Adapter::NilAdapter.new) 

end
