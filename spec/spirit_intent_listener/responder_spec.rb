require 'spec_helper'

describe Responder do
  let(:params) { '{"preset": {"id": "718bbaa6-85f1-11e2-935e-d611d120ea23"}}' }
  describe "initialization" do
    it 'receives a string of the params and stores it' do
      subject = Responder.new(params)
      expect(subject.params).to eql(params)
    end
  end
end
