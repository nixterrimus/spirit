require 'spec_helper'

describe PresetSerializer do
  let(:preset) { Preset.new }
  let(:serializer) { PresetSerializer.new(preset) }

  describe '#as_json' do
    let(:subject) { serializer.as_json[:preset] }
    its([:name]) { should == preset.name }
    its([:id]) { should == preset.id }
  end

end
