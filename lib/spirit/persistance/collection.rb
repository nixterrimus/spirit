module Persistance
  module Collection
    module ClassMethods
      def find_or_initialize_in(persistance_store)
        persistance_key = self.to_s.downcase
        persistance_store.stored?(persistance_key) ? persistance_store.load(persistance_key) : self.new
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def member_uuids=(uuids)
      @member_uuids = uuids
    end

    def member_uuids
      @member_uuids
    end

    # Used to store to the persistance store
    def persistance_key
      self.class.name.downcase
    end

    # Used to store to the persistance store
    def to_hash
      { member_uuids: uuids }
    end

    def before_save
      each { |member| member.save }
    end

    def after_load
      member_uuids.each { |uuid| self << persistance_store.load(uuid) }
    end

    def uuids
      self.collect { |d| d.uuid }
    end

  end
end
