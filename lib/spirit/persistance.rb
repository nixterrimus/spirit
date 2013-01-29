require 'spirit/persistance/collection'

module Persistance

  def update_attributes(attributes = {})
    attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
  end

  def marshal_dump
    self.to_hash
  end

  def to_hash
    {}
  end

  def marshal_load attributes_hash
    self.update_attributes(attributes_hash)
    after_load
  end

  def after_load; nil; end

  def save
    before_save
    persistance_store.save(self)
  end

  def before_save; nil; end

  def persistance_store
    Spirit.persistance
  end
end
