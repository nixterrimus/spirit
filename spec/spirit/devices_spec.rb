require 'spec_helper'

describe Devices do
  subject { Devices.new }
  describe 'find' do
    context 'with devices available' do
      let(:target) { OpenStruct.new( { uuid: 1 }) }
      before do
        subject << target
      end
      it 'returns the target uuid' do
        expect(subject.find(target.uuid)).to be(target)
      end
    end
    context 'with no devices' do
      before do
        subject = []
      end
      it 'returns nil' do
        expect(subject.find('not-in-the-array')).to be(nil)
      end
    end
  end
end
