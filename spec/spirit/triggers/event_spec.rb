require 'spec_helper'

describe Event do
  subject { Event.new }

  describe 'attributes' do
    it 'has a raw payload' do
      expect(subject.respond_to? :raw_payload).to eql(true)
    end
    it 'has a channel' do
      expect(subject.respond_to? :channel).to eql(true)
    end
  end
end
