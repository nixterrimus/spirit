require 'spec_helper'

describe ColorableLight do
  subject { ColorableLight.new }

  its(:abilities) { should(include 'switchable') }
  its(:abilities) { should(include 'dimmable') }
  its(:abilities) { should(include 'colorable') }
  

end
