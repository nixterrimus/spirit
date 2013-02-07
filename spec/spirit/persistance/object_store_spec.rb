require 'spec_helper'

class PersistableObject
  def persistance_key
    "persistance_key"
  end

  def persistance_value
    Marshal.dump(self)
  end
end

describe ObjectStore do
  let(:persistance_store) { Moneta.new(:Memory) }
  let(:subject) { ObjectStore.new(persistance_store) }
  let(:persistable_object) { PersistableObject.new }

  describe "initialization" do
    it 'requires a persistance store' do
      expect { ObjectStore.new }.to raise_error
      expect { ObjectStore.new(persistance_store) }.to be
    end
  end

  describe 'save' do
    it 'saves the object to the persistance store' do
      persistance_store.should_receive(:store).once
      subject.save(persistable_object)
    end

    it 'saves the object with the `persistance_key`' do
      persistable_object.should_receive(:persistance_key).once
      subject.save(persistable_object)
    end

    it 'saves the object with the `persistance_value`' do
      persistable_object.should_receive(:persistance_value).once
      subject.save(persistable_object)
    end
  end

  describe 'load' do
    before do
      subject.save(persistable_object)
    end
    it 'loads the target key' do
      loaded_object = subject.load(persistable_object.persistance_key)
      expect(loaded_object).to_not be_nil
      expect(loaded_object.persistance_key).to match(persistable_object.persistance_key)
    end

    it 'always returns the same instance for a given key' do
      loaded_object = subject.load(persistable_object.persistance_key)
      loaded_object_2 = subject.load(persistable_object.persistance_key)
      expect(loaded_object).to equal(loaded_object_2)
    end
  end

  describe 'stored?' do 
    before do
      subject.save(persistable_object)
    end
    it 'returns true if the target key is in the store' do
      expect(subject.stored?(persistable_object.persistance_key)).to be_true
    end

    it 'returns false if the targe key is not in the store' do
      expect(subject.stored?(Time.now.to_s)).to be_false
    end
  end
end
