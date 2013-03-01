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

  describe '.first' do
    before do
      subject.stub(:all).and_return(['1', '2', '3'])
    end
    it 'returns the first result from all' do
      subject.should_receive(:all).once
      expect(subject.first).to eql('1')
    end
  end

  describe '.last' do
    before do
      subject.stub(:all).and_return(['1', '2', '3'])
    end
    it 'returns the last result from all' do
      subject.should_receive(:all).once
      expect(subject.last).to eql('3')
    end
  end

  describe 'the class is subclassed' do
    it 'the parent adds its persistence keys to the child' do
      test_class = Tester
      test_class.should_receive(:add_persistence_keys).once.with(subject.persistence_keys)
      subject.inherited(test_class)
    end
  end
end
