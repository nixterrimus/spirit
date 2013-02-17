require 'spec_helper'

describe Device do
  subject { Device.new }
  let(:fake_adapter) { OpenStruct.new( { id: 123 }) }

  describe '#abilities' do
    before do
      abilities = [ Abilities::Switchable ]
      subject.class.stub(:included_modules).and_return(abilities)
    end
    it 'includes a list of modules that are included from the abilities namespace' do
      subject.abilities.should include('switchable')
    end
  end

  describe "#device_adapter" do
    context 'when a device adapter is already set' do
      before do
        subject.device_adapter = fake_adapter
      end
      it 'returns that adapter' do
        expect(subject.device_adapter).to be(fake_adapter)
      end
    end

    context 'when the device adapter is nil' do
      before do
        subject.device_adapter = nil
      end
      it 'returns a default adapter' do
        expect(subject.device_adapter).to_not be(nil)
      end
    end
  end

  describe "#device_adapter=" do
    it 'sets the device_adapter to the new adapter' do
      subject.device_adapter = fake_adapter
      expect(subject.device_adapter.id).to eql(fake_adapter.id)
    end
  end

  describe "after saving" do
    it 'applies the current state' do
      subject.should_receive(:apply_state).once
      subject.save
    end
  end
end
