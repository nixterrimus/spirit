require 'spec_helper'

describe DeviceSerializer do
  let(:device) { Device.new }
  let(:serializer) { DeviceSerializer.new(device) }

  describe '#as_json' do
    let(:subject) { serializer.as_json[:device] }
    its([:name]) { should == device.name }
    its([:id]) { should == device.id }
    its([:abilities]) { should == device.abilities }
    its([:state]) { should == device.current_state }
    its([:type]) { should == device.type }
  end
end
