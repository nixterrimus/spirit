module Persistable
  def persistance_key; nil; end

  def persistance_value
    Marshal.dump(self)
  end

  def save
    before_save
    persistance_store.save(self)
    after_save
  end

  def before_save; nil; end
  def after_save; nil; end

  def persistance_store
    Spirit.persistance
  end
end
