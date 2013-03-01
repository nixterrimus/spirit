module Toy
  module Store
    module All
      extend ActiveSupport::Concern

      included do
        after_save :add_to_all_pool
      end

      module ClassMethods
        def all_ids
          adapter.read(all_persistence_key)
        end

        def all
          self.all_ids.nil? ? [] : self.all_ids.collect { |id| self.read(id) }
        end

        def all_persistence_key
          ActiveModel::Naming.plural(self)
        end

        def persistence_keys
          @persistence_keys ||= [ self.all_persistence_key ]
        end

        def add_persistence_keys(*keys)
          @persistence_keys = (self.persistence_keys + keys).flatten
        end

        def first
          self.all.first
        end

        def last
          self.all.last
        end

        def inherited(subclass)
          super
          subclass.add_persistence_keys(self.persistence_keys)
        end

      end

      private

      def add_to_all_pool
        self.class.persistence_keys.each do |key|
          write_unique_set_to_key(key)
        end
      end

      def ids_for_key(key)
        adapter.read(key) || []
      end

      def uniquely_add_self_to_key(key)
        ids_for_key(key).push(self.id).uniq
      end

      def write_unique_set_to_key(key)
        adapter.write(key, uniquely_add_self_to_key(key))
      end
    end
  end
end
