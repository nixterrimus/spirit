require 'spec_helper'

shared_examples_for Persistable do |object|
  it 'should respond to persistance_key' do
    expect{ object.persistance_key }.to_not raise_error
  end

  it 'should respond to persistance_value' do
    expect{ object.persistance_key }.to_not raise_error
  end

  it 'should respond to save' do
    expect { object.save }.to_not raise_error
  end

  describe 'save' do
    it 'calls before_save on before saving' do
      object.should_receive(:before_save)
      object.save
    end

    it 'calls after_save after saving' do
      object.should_receive(:after_save)
      object.save
    end
  end

  describe 'persistance_store' do
    it 'returns an instance on ObjectStore' do
      expect(object.persistance_store.class).to be(ObjectStore)
    end
  end
end

class DummyClass
  include Persistable
end

describe "Persistable" do
  it_should_behave_like Persistable, DummyClass.new
end

