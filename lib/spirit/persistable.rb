module Persistable
  def persistance_key; nil; end

  def persistance_value
    Marshal.dump(self)
  end
end
