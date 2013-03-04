require 'spec_helper'

describe EventListener do
  subject { EventListener.new }
  let(:channel) { 'event.testEvent' }
  let(:message) { {} }
  let(:test_trigger) { Trigger.new }

  describe "#listen" do

  end

  describe "#event_received" do
    it 'creates a new event' do
      Event.should_receive(:new).once
      subject.event_received(channel, message)
    end
  end

  describe "#triggers" do 
    it 'returns an array' do
      expect(subject.triggers.class).to eql(Array)
    end
  end
  

  describe "#stop_listening" do

  end
end
