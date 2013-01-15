require 'spec_helper'

shared_examples_for Capability::BinaryDevice do |device|
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
  end

  describe 'off' do
    it 'sets the state to off' do
      device.binary_state = :on
      device.off
      expect(device.binary_state).to be(:off)
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
    it 'flips the state of the device' do
      device.on
      device.toggle
      expect(device.off?).to be_true
      device.toggle
      expect(device.on?).to be_true
    end
  end
end
