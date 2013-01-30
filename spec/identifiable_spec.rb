require 'spec_helper'

shared_examples_for Identifiable do |device|
  describe 'the uuid attribute' do
    context 'is not set' do
      before(:each) do
        device.uuid = nil
      end

      it 'sets a uuid' do
        expect(device.uuid).to_not be_nil
      end

      it 'generates a uuid by calling generate_uuid' do
        device.should_receive(:generate_uuid).once
        device.uuid
      end
    end
    
    it 'stays constant between calls' do
      expect(device.uuid).to equal(device.uuid)
    end
  end 
end
