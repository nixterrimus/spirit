require 'spec_helper'

describe Device do
  subject { Device.new }
  let(:fake_driver) { OpenStruct.new( { id: 123 }) }

  its(:attributes) { should include 'driver_id' }
  its(:attributes) { should include 'driver_identifier' }
  its(:attributes) { should include 'name' }

  describe '#name' do
    it 'defaults to device' do
      expect(subject.name).to eql('Device')
    end
  end

  describe 'uniqness' do
    context 'on create' do
      let(:driver_id) { 1 }
      let(:driver_identifier) { 1 }
      it "validates there's only one device with the same driver_id and driver_identifier" do
        Device.create( driver_identifier: driver_identifier, driver_id: driver_id)
        expect do
         Device.create!( driver_identifier: driver_identifier, driver_id: driver_id)
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

  describe "#current_state" do
    it 'returns a hash with the current state' do
      expect(subject.current_state.class).to eql(Hash)
    end

    it 'uses the current state attributes' do
      subject.should_receive(:current_state_attributes).and_return([])
      subject.current_state
    end
  end

  describe "#current_state_attributes" do
    it 'returns an array' do
      expect(subject.current_state_attributes.class).to eql(Array)
    end
  end

  describe "#driver" do
    context 'when a device driver is already set' do
      it 'returns that driver' do
        subject.driver = fake_driver
        expect(subject.driver).to be(fake_driver)
      end
    end
  end

  describe "#driver=" do
    it 'sets the driver to the new driver' do
      subject.driver = fake_driver
      expect(subject.driver.id).to eql(fake_driver.id)
    end
  end

  describe "after updating" do
    it 'applies the current state' do
      subject.should_receive(:apply_state)
      subject.send(:update)
    end
  end
end
