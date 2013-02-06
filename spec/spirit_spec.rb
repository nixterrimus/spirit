require 'spec_helper'

describe Spirit do
  describe 'devices' do
    let(:devices) { 3.times.collect { Device::Light.new } }
    context 'when there are no devices' do
      it 'is empty' do
        expect(Spirit.devices).to be_empty
      end
      context 'when there are devices' do
        it 'returns a list of devices' do
          devices.each { |d| Spirit.devices <<  d }
          expect(Spirit.devices.length).to be(3)
          devices.each do |device|
            expect(Spirit.devices.include? device).to be_true
          end
        end
      end
    end
  end

  describe 'presets' do
    it 'returns a list' do
      expect(Spirit.presets).to be_empty
    end
  end

  describe 'persistance' do
    it 'returns an object store' do
      expect(Spirit.persistance.class).to be(ObjectStore)
    end

    it 'always returns the same instance' do
      expect(Spirit.persistance).to be(Spirit.persistance)
    end
  end

end
