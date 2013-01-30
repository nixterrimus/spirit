require 'spirit/identifiable'
require 'spirit/adapter/base'
require 'spirit/adapter/nil_adapter'
class Adapters < Array
  include Persistable::Collection
end
