require 'spec_helper'

class TestDevice < Device
  include Abilities::Dimmable
end

describe Abilities::Dimmable do |device|
  subject{ TestDevice.new }

  describe 'attributes' do
    it 'has a level attribute' do
      expect(subject.attributes).to include('level')
    end
  end

  describe 'validations' do
    describe 'level' do
      it 'is greater than or equal to 0' do
        subject.level = 0
        expect(subject.valid?).to be(true)
        subject.level = -1
        expect(subject.valid?).to be(false)
      end
      it 'is less than or equal to 100' do
        subject.level = 100
        expect(subject.valid?).to be(true)
        subject.level = 101
        expect(subject.valid?).to be(false)
      end
    end
  end
end
