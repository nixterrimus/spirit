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
          "#{self.to_s.downcase}s"
        end

        def first
          self.all.first
        end

        def last
          self.all.last
        end
      end

      private

      def add_to_all_pool
        known_ids = self.class.all_ids || []
        all = known_ids.push(self.id)
        adapter.write(self.class.all_persistence_key, all)
      end
    end
  end
end
