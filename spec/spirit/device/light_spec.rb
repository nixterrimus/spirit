require 'spec_helper'

describe Light do
  subject { Light.new }

  its(:abilities) { should(include 'switchable') }
end
