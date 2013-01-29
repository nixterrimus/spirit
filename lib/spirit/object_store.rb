class ObjectStore

  attr_accessor :persistance_store

  def initialize(persistance_store)
    @persistance_store = persistance_store
    @cached_objects = {}
  end

  def save(object)
    persistance_store.store(object.persistance_key, object.persistance_value)
  end

  def load(key)
     @cached_objects[key] || load_and_cache(key)
  end

  def stored?(key)
    persistance_store.key? key
  end

  private

  def cache_object(key, value)
    @cached_objects[key] = value
  end

  def load_and_cache(key)
    device_dump = persistance_store.fetch(key)
    loaded_object = Marshal.load(device_dump)
    cache_object(key, loaded_object)
    return loaded_object
  end
end
