require 'spec_helper'

describe Preset do
  it_should_behave_like Identifiable, Preset.new
  subject { Preset.new }
  let(:device) { Device::Light.new }
  let(:ephemeral_attribute_values) { { a: 1, b: 2 } }

  describe 'adding a device' do
    it 'stores the devices empheral attributes' do
      device.should_receive(:ephemeral_attribute_values).once.and_return(ephemeral_attribute_values)
      subject.add_device(device)
    end
  end

  describe 'device_uuids' do
    before do
      subject.add_device(device)
    end
    it 'returns a list of all devices that are part of the preset' do
      subject.device_uuids.should include device.uuid
    end
  end
end
