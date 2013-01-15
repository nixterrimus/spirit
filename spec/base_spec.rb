require 'spec_helper'

describe Device::Base do
  let(:adapter) { OpenStruct.new }
  describe 'initialization' do
    it 'requires an adapter' do
      expect{ Device::Base.new }.to raise_error
      expect{ Device::Base.new(adapter)}.to_not be_nil
    end
  end
end
