require 'spec_helper'

describe Device do
  subject { Device.new }
  let(:fake_adapter) { OpenStruct.new( { id: 123 }) }

  its(:attributes) { should include 'device_adapter_id' }
  its(:attributes) { should include 'device_adapter_identifier' }
  its(:attributes) { should include 'name' }

  describe '#name' do
    it 'defaults to device' do
      expect(subject.name).to eql('Device')
    end
  end

  describe 'uniqness' do
    context 'on create' do
      let(:device_adapter_id) { 1 }
      let(:device_adapter_identifier) { 1 }
      it "validates there's only one device with the same device_adapter_id and device_adapter_identifier" do
        Device.create( device_adapter_identifier: device_adapter_identifier, device_adapter_id: device_adapter_id)
        expect do
         Device.create!( device_adapter_identifier: device_adapter_identifier, device_adapter_id: device_adapter_id)
        end.to raise_error
      end
    end

  end

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
      it 'returns that adapter' do
        subject.device_adapter = fake_adapter
        expect(subject.device_adapter).to be(fake_adapter)
      end
    end
  end

  describe "#device_adapter=" do
    it 'sets the device_adapter to the new adapter' do
      subject.device_adapter = fake_adapter
      expect(subject.device_adapter.id).to eql(fake_adapter.id)
    end
  end

  describe "after updating" do
    it 'applies the current state' do
      subject.should_receive(:apply_state)
      subject.send(:update)
    end
  end
end
