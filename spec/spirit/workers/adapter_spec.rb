require 'spec_helper'

module SuckerPunch::Worker
  # prevent this from being a real worker
end

describe Worker::AdapterWorker do

  subject { Worker::AdapterWorker.new }

  describe "#perform" do
    let(:device_id) { 123 }
    let(:adapter_id) { 321 }
    it 'loads the device, adapter, and applies' do
      device = double("Device")
      adapter = double("Adapter::Base")
      Adapter::Base.should_receive(:read).with(adapter_id).and_return(adapter.as_null_object)
      Device.should_receive(:read).with(device_id).and_return(device.as_null_object)
      adapter.should_receive(:apply).with(device).once
      subject.perform(device_id, adapter_id)
    end
  end
end
