require 'spec_helper'

describe PresetAction do
  subject { PresetAction.new }
  describe 'attributes' do
    it 'preset_id' do
      expect(subject.respond_to? :preset_id).to eql(true)
    end
  end

  describe '#preset' do
    let(:preset_id) { 123 }
    it 'finds the preset with the matching preset_id' do
      subject.stub(:preset_id).and_return(preset_id)
      Preset.should_receive(:find).once.with(preset_id)
      subject.preset
    end
  end

  describe '#apply' do
    let(:preset) { Preset.new }
    it 'applies the preset' do
      subject.stub(:preset).and_return(preset)
      preset.should_receive(:apply).once
      subject.apply
    end
  end
end
