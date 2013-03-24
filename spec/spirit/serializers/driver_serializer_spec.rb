require 'spec_helper'

describe DriverSerializer do
  let(:driver) { Driver::Base.new }
  let(:serializer) { DriverSerializer.new( driver ) }

  describe '#as_json' do
    let(:subject) { serializer.as_json[:driver] }
    its([:id]) { should == driver.id }
  end
end
