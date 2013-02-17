require 'spec_helper'

class TestDevice < Device
  include Abilities::Colorable
end

describe Abilities::Colorable do |device|
  subject{ TestDevice.new }

  describe 'attributes' do
    it 'has a red_level attribute' do
      expect(subject.attributes).to include('red_level')
    end
    it 'has a green_level attribute' do
      expect(subject.attributes).to include('green_level')
    end
    it 'has a blue_level attribute' do
      expect(subject.attributes).to include('blue_level')
    end

  end

  describe 'validations' do
    describe 'red_level' do
      it 'is in the range 0-100' do
        in_range_validation('red_level', 0, 100)
      end
    end
    describe 'green_level' do
      it 'is in the range 0-100' do
        in_range_validation('red_level', 0, 100)
      end
    end
    describe 'blue_level' do
      it 'is in the range 0-100' do
        in_range_validation('red_level', 0, 100)
      end
    end
  end
end

private

def in_range_validation(method, low, high)
  subject.send("#{method}=", low-1)
  expect(subject.valid?).to be(false)
  subject.send("#{method}=", low)
  expect(subject.valid?).to be(true)
  subject.send("#{method}=", high)
  expect(subject.valid?).to be(true)  
  subject.send("#{method}=", high+1)
  expect(subject.valid?).to be(false)
end

