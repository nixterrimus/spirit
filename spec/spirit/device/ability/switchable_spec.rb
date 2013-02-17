require 'spec_helper'

class TestDevice < Device
  include Abilities::Switchable
end

describe Abilities::Switchable do |device|
  subject{ TestDevice.new }

  describe 'attributes' do
    it 'has a binary_sate attribute' do
      expect(subject.attributes).to include('binary_state')
    end
  end

  describe 'validations' do
    describe 'binary_sate' do
      it 'validates :on is valid' do
        subject.binary_state  = :on
        expect(subject.valid?).to be(true)
      end
      it 'validates :off is valid' do
        subject.binary_state  = :off
        expect(subject.valid?).to be(true)
      end
    end
  end
end
