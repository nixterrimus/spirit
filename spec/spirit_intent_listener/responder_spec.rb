require 'spec_helper'

describe Responder do
  let(:params) { '{"preset": {"id": "718bbaa6-85f1-11e2-935e-d611d120ea23"}}' }
  let(:subject) { Responder.new(params) }
  describe "initialization" do
    it 'receives a string of the params and stores it' do
      subject = Responder.new(params)
      expect(subject.params).to eql(params)
    end
  end

  describe '#parse_params' do
    it 'stores the pared params to parsed_params' do
      expect(subject.parsed_params).to eql(nil)
      subject.parse_params
      expect(subject.parsed_params).to_not eql(nil)
    end
    it 'decodes the params' do
      pending
    end
  end
end
