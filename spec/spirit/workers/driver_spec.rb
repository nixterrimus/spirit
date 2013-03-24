require 'spec_helper'

module SuckerPunch::Worker
  # prevent this from being a real worker
end

describe Worker::DriverWorker do

  subject { Worker::DriverWorker.new }

  describe "#perform" do
    let(:device_id) { 123 }
    let(:driver_id) { 321 }
    it 'loads the device, driver, and applies' do
      device = double("Device")
      driver = double("Driver::Base")
      Driver::Base.should_receive(:read).with(driver_id).and_return(driver.as_null_object)
      Device.should_receive(:read).with(device_id).and_return(device.as_null_object)
      driver.should_receive(:apply).with(device).once
      subject.perform(device_id, driver_id)
    end
  end
end
