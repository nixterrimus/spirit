require 'spec_helper'

class Tester
  include Toy::Store
  include Toy::Store::All
end

describe Toy::Store::All do
  subject { Tester }
  describe ".all_persistence_key" do
    it 'returns a string' do
      expect(subject.all_persistence_key.class).to be(String)
    end
  end

  describe ".all_ids" do 
    it 'reads ids from the adapter' do
      subject.adapter.should_receive(:read).once
      subject.all_ids
    end
  end

  describe ".all" do
    context "there are no ids stored" do
      it 'returns an empty array' do
        subject.stub(:all_ids).and_return(nil)
        expect(subject.all).to eql([])
      end
    end
  end

  describe ".persistence_keys" do
    it 'is an array' do
      expect(subject.persistence_keys.class).to be(Array)
    end
    it 'includes the class persistence_key' do
      expect(subject.persistence_keys).to include(subject.all_persistence_key)
    end
  end

  describe ".add_persistence_keys" do
    it 'adds the array to the existing persistence_keys' do
      subject.should_receive(:persistence_keys).once.and_return([])
      subject.add_persistence_keys(['key'])
    end
  end
end
