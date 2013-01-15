require 'spec_helper'

describe Adapter::NilAdapter do
  let(:subject) { Adapter::NilAdapter.new }

  it 'returns nil for all calls' do
    expect(subject.on).to be_nil
    expect(subject.off).to be_nil
    expect(subject.play).to be_nil
  end
end
