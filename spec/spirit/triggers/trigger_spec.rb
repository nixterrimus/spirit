require 'spec_helper'
require 'ostruct'

describe Trigger do
  subject { Trigger.new }
  let(:target_event) { "test_event" }
  let(:event) { OpenStruct.new( { channel: target_event } ) }

  it 'has attributes' do
    expect(subject.class.attributes).to include('target_event')
    expect(subject.class.attributes).to include('action_id')
  end

  describe "#apply" do
    let(:action) { Action.new }
    context 'the event is applicable' do
      it 'applies the action' do
        subject.stub(:action).and_return(action)
        subject.stub(:applicable?).and_return(true)
        subject.stub(:worker)
        subject.worker.should_receive(:perform!).with(action)
        subject.apply(event)
      end
    end
  end

  describe "#action" do
    let(:action_id) { 123 }
    it 'loads the action with action_id' do
      subject.stub(:action_id).and_return(action_id)
      Action.should_receive(:read).with(action_id)
      subject.action
    end
  end

  describe "#applicable?" do
    context 'the event is nil' do
      it 'returns false' do
        expect(subject.applicable?(nil)).to eql(false)
      end
    end
    context 'the target_event is equal to the event channel' do
      it 'returns true' do
        subject.stub(:target_event).and_return(target_event)
        expect(subject.applicable?(event)).to eql(true)
      end
    end 
    context 'the target_event is not equal to the event channel' do
      it 'returns false' do
        subject.stub(:target_event).and_return("#{target_event}-not")
        expect(subject.applicable?(event)).to eql(false)
      end
    end
  end

end
