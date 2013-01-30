require 'spirit/identifiable'
require 'spirit/adapter/base'
require 'spirit/adapter/nil_adapter'
require 'spirit/adapter/hue_adapter'

class Adapters < Array
  include Persistable::Collection
end
