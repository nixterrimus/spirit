require 'spec_helper'

describe DimmableLight do
  subject { DimmableLight.new }

  its(:abilities) { should(include 'switchable') }
  its(:abilities) { should(include 'dimmable') }
  
end

