require 'spec_helper'

shared_examples_for Persistable do |object|
  it 'should respond to persistance_key' do
    expect{ object.persistance_key }.to_not raise_error
  end

  it 'should respond to persistance_value' do
    expect{ object.persistance_key }.to_not raise_error
  end
end

class DummyClass
  include Persistable
end

describe "Persistable" do
  it_should_behave_like Persistable, DummyClass.new
end

