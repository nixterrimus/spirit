module Device
  module Abilities

  end
end

Dir[File.join(File.dirname(__FILE__), 'abilities', '*.rb')].each {|file| require file }

