module Poolable
  include Enumerable
  
  def pool
    @pool ||= {}
  end

  def add(device)
    self.pool[device.uuid] = device
  end

  def remove(device)
    self.pool.delete(device.uuid)
  end

  def each(&block)
    self.pool.values.each(&block)  
  end
  
end
