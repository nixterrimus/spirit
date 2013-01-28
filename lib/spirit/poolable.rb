module Poolable
  include Enumerable
  
  def pool
    @pool ||= {}
  end

  def add(device)
    self.pool[device.uuid] = device
    self.after_add(device)
  end

  def after_add(device)
    nil
  end

  def remove(device)
    self.pool.delete(device.uuid)
    self.after_remove(device)
  end

  def after_remove(device)
    nil
  end

  def each(&block)
    self.pool.values.each(&block)  
  end

  def pool_uuids
   self.pool.keys
  end

  
end
