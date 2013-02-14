require 'spirit/device/device'
require 'spirit/device/light'
require 'spirit/device/dimmable_light'
require 'spirit/device/colorable_light'

class Devices < Array
  def find(uuid)
    select { |item| item.uuid == uuid }.first
  end
end
