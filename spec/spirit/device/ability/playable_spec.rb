require 'spec_helper'

class TestDevice < Device
  include Abilities::Playable
end

describe Abilities::Playable do
  subject { TestDevice.new }
  describe 'attributes' do
    it 'has a play_state attribute' do
      expect(subject.respond_to? :play_state).to eql(true)
    end
    it 'defaults play_state to :stopped' do
      expect(subject.play_state).to eql(:stopped)
    end
  end

  describe 'validations' do
    describe 'play_state' do
      it 'validates :playing is valid' do
        subject.play_state = :playing
        expect(subject.valid?).to eql(true)
      end
      it 'validates :stopped is valid' do
        subject.play_state = :stopped
        expect(subject.valid?).to eql(true)
      end
      it 'validates :stopped is valid' do
        subject.play_state = :paused
        expect(subject.valid?).to eql(true)
      end
    end
  end
end
