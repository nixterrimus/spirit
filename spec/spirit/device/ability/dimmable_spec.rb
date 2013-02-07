require 'spec_helper'

shared_examples_for Device::Abilities::Dimmable do |device|
  let(:too_low_value) { device.min_level - 1 }
  let(:too_high_value) { device.max_level + 1}

  describe 'level' do
    it 'defaults to 0' do
      expect(device.level).to be(0)
    end
  end 

  describe 'setting level' do
    it 'does not accept values less than 0' do
      expect { device.level = too_low_value }.to raise_error
    end

    it 'does not accept values greater than 100' do
      expect { device.level = too_high_value }.to raise_error
    end

    it 'saves values within the valid range' do
      target_level = 55
      device.level = target_level
      expect(device.level).to be(target_level)
    end
  end

  describe 'dim up' do
    it 'increases the level by the passed argument' do
      device.level = 0
      device.dim_up(10)
      expect(device.level).to be(10)
    end

    it 'sends the `apply_state` signal to the adapter' do
      device.should_receive(:apply_state)
      device.dim_up(10)
    end
  end

  describe 'dim down' do
    it 'decreases the level by the passed argument' do
      device.level = 50
      device.dim_down(10)
      expect(device.level).to be(40)
    end

    it 'sends the `apply_state` signal to the adapter' do
      device.should_receive(:apply_state)
      device.dim_up(10)
    end
  end

  describe 'valid_level' do

    it 'ensures the level is greater than the min_level' do
      expect(device.valid_level?(too_low_value)).to be(false)
    end

    it 'ensures the level is less than the max_level' do
      expect(device.valid_level?(too_high_value)).to be(false)
    end
  end

end
