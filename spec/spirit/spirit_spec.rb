require 'spec_helper'

describe Spirit do
  describe '#devices' do
    it 'delegates to Device.all' do
      Device.should_receive(:all).once
      Spirit.devices
    end
  end

  describe '#presets' do
    it 'delegates to Preset.all' do
      Preset.should_receive(:all).once
      Spirit.presets
    end
  end

end
