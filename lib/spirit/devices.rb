require 'spirit/device/abilities'
require 'spirit/device/base'
require 'spirit/device/light'
require 'spirit/device/dimmable_light'
require 'spirit/device/colorable_light'

class Devices < Array
  include Persistable::Collection
end
