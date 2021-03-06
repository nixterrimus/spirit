require 'spec_helper'

describe Responder do
  let(:params) { '{"preset": {"id": "718bbaa6-85f1-11e2-935e-d611d120ea23"}}' }
  let(:channel) { 'intents.spirit.applyPreset' }
  subject(:responder) { Responder.new(channel, params) }

  describe "initialization" do
    it 'receives a string of the params and stores it' do
      expect(responder.params).to eql(params)
    end
    it 'receives the channel the params were receive on and stores it' do
      expect(responder.channel).to eql(channel)
    end
    it 'parses the params' do
      expect(responder.parsed_params).to_not eql(nil)
    end
  end

  describe '#parse_params' do
    it 'stores the pared params to parsed_params' do
      responder.parse_params
      expect(responder.parsed_params).to_not eql(nil)
    end
    it 'decodes the params' do
      responder.parse_params
      expect{ responder.parsed_params.fetch(:preset).fetch(:id) }.to_not raise_error
      expect(responder.parsed_params.fetch(:preset).fetch(:id)).to eql("718bbaa6-85f1-11e2-935e-d611d120ea23")
    end
  end

  describe '#intent_class_name' do
    it 'parses the channel to get the appropriate name' do
      expect(subject.intent_class_name).to eql('ApplyPreset')
    end
  end

  describe "#intent_class" do
    context 'the intent is present in the system' do
      it 'returns a class of the intent in the intent namespace' do
        expect(subject.intent_class).to eql(Intent::ApplyPreset)
      end
    end
  end

  describe "#intent" do
    it 'returns an instance on the intent_class' do
      expect(subject.intent.class).to eql(Intent::ApplyPreset)
    end
    it 'memoizes the result so the intent is always the same' do
      object_id = subject.intent.object_id
      expect(subject.intent.object_id).to eql(object_id)
      expect(subject.intent.object_id).to eql(object_id)
      expect(subject.intent.object_id).to eql(object_id)
    end
  end

  describe '#apply' do
    it 'sends the parsed_params to the intent_class apply' do
      subject.intent_class.any_instance.should_receive(:apply).with(subject.parsed_params)
      subject.apply
    end
  end

  describe "Using a Responder" do
    it 'can be initialized and applied' do
      Intent::ApplyPreset.any_instance.should_receive(:apply).with(subject.parsed_params)
      expect { Responder.new(channel, params).apply }.to_not raise_error
    end
  end
end
