module Persistable
  module Member
    include ::Persistable    

    def persistance_value
      Marshal.dump(self.to_hash)
    end

    def marshal_load attributes_hash
      self.update_attributes(attributes_hash)
      after_load
    end    

    def update_attributes(attributes = {})
      attributes.each { |key, val| send("#{key}=", val) if respond_to?("#{key}=") }
    end
    
    def to_hash
      {}
    end    

    def after_load; nil; end

  end
end
