require 'spec_helper'

describe Device do
  let(:adapter) { OpenStruct.new }
  subject { Device::Base.new }
  describe 'initialization' do
    it 'accepts an adapter' do
      fake_adapter = 'FakeAdapter'
      expect(Device::Base.new(adapter: fake_adapter).adapter).to equal(fake_adapter)
    end

    context 'no adapter is passed' do
      it 'sets a default adapter' do
        expect(Device::Base.new.adapter).to_not be_nil
      end
    end
  end

  describe '#device_adapter' do

  end

  describe '#abilities' do
    before do
      abilities = [ Device::Abilities::Switchable ]
      subject.class.stub(:included_modules).and_return(abilities)
    end
    it 'includes a list of modules that are included from the abilities namespace' do
      subject.abilities.should include('switchable')
    end
  end

  describe "update_attributes!" do
    it 'takes a hash and updates attributes' do
      subject.should_receive(:update_attributes).once
      subject.update_attributes!( { attribute: 1 })
    end

    it 'applies the state' do
      subject.should_receive(:apply_state).once
      subject.update_attributes!( { attribte: 1 } )
    end
  end

  describe "ephemeral_attribute_values" do
    it 'returns a hash of the empheral attributes with values' do
      subject.class.stub(:ephemeral_attributes).and_return([:foo])
      subject.stub(:foo).and_return(1)
      expect(subject.ephemeral_attribute_values[:foo]).to be(1)
    end
  end
end
