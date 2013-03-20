require 'spec_helper'

describe DeviceSerializer do
  let(:adapter) { Adapter::Base.new }
  let(:serializer) { AdapterSerializer.new( adapter ) }

  describe '#as_json' do
    let(:subject) { serializer.as_json[:adapter] }
    its([:id]) { should == adapter.id }
  end
end
