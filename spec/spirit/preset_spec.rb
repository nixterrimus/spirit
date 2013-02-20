require 'spec_helper'

describe Preset do
  subject { Preset.new }
  let(:device) { Light.new }

  describe '#add_device' do
    context 'when the device is not persisted' do
      it 'raises an error' do
        expect{ subject.add_device(device) }.to raise_error
      end
    end

    context 'when the device is persisted' do
      before do
        device.stub(:persisted?).and_return(true)
      end
      it 'saves the device_id' do
        subject.add_device(device)
        expect(subject.device_ids).to include(device.id)
      end

      it 'gets the device attributes' do
        device.should_receive(:attributes).once.and_call_original
        subject.add_device(device)
      end
    end
  end

  describe "#devices" do
    it 'reads from the persistence store' do
      subject.stub(:device_ids).and_return( [1] )
      Device.should_receive(:read).once
      subject.devices
    end
  end
end
