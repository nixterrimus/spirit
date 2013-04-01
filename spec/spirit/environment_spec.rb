require 'spec_helper'

describe Environment do
  subject(:environment) { Environment.new }
  it 'has many devices' do
    expect(environment.devices.class).to eql(Array)
  end

  it 'has many drivers' do
    expect(environment.drivers.class).to eql(Array)
  end

  it 'has many presets' do
    expect(environment.presets.class).to eql(Array)
  end

  it 'has an id' do
    expect(environment.id).to_not be_nil
  end

  describe "name" do
    it 'defaults to home' do
      expect(environment.name).to eql("Home")
    end

    it 'is settable' do
      new_name = "The loft"
      environment.name = new_name
      expect(environment.name).to eql(new_name)
    end
  end
end
