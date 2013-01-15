module Adapter
  class NilAdapter
    def method_missing(meth, *args, &block)
      nil
    end
  end
end
