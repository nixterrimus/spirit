require 'spec_helper'

shared_examples_for Abilities::Switchable do |device|

  it 'responds to binary_state' do
    expect { device.binary_state }.to_not raise_error(NoMethodError)
  end

  describe 'binary state' do
    it 'defaults to unknown state' do
      expect(device.binary_state).to be(:unknown)
    end

  end

  describe 'setting binary state' do
    it 'accepts valid states' do
      device.binary_state = :on
      expect(device.binary_state).to be(:on)
    end

    it 'rejects invalid state' do
      expect{ device.binary_state = :searching }.to raise_error
    end
  end
end
