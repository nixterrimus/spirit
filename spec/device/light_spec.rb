require 'spec_helper'

describe Device::Light do
  let!(:subject) { Device::Light.new }

  it_should_behave_like Capability::BinaryDevice, Device::Light.new

  it 'exists' do
    #binding.pry
  end
end
