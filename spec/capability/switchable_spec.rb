require 'spec_helper'

shared_examples_for Capability::Switchable do |device|
  it 'responds to binary_state' do
    expect { device.binary_state }.to_not raise_error(NoMethodError)
  end

  it 'allows binary_state to be set' do
    device.binary_state = :on
    expect(device.binary_state).to be(:on)
  end

  describe 'on' do
    it 'sets the state to on' do
      device.binary_state = :off
      device.on
      expect(device.binary_state).to be(:on)
    end

    it 'tells the adapter to turn on' do
      device.adapter.should_receive(:on).with(device).once
      device.on
    end
  end

  describe 'off' do
    it 'sets the state to off' do
      device.binary_state = :on
      device.off
      expect(device.binary_state).to be(:off)
    end
    it 'tells the adapter to turn off' do
      device.adapter.should_receive(:off).with(device).once
      device.off
    end
  end

  describe 'on?' do
    it 'is true if the device state is :on' do
      device.on
      expect(device.on?).to be_true
    end
  end

  describe 'off?' do
    it 'is true if the device state is :off' do
      device.off
      expect(device.off?).to be_true
    end
  end

  describe 'toggle' do
    context 'when off' do
      it 'calls on' do
        device.should_receive(:on)
        device.off
        device.toggle
      end
    end
    context 'when on' do
      it 'calls off' do
        device.should_receive(:off)
        device.on
        device.toggle
      end
    end
  end
end
