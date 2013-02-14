module Adapter
  class Base
    include Toy::Store

    attr_accessor :setup_complete

    class Setting
      attr_accessor :value_type, :current_value, :description

      def initialize(options = {})
      end
    end

    class RegisteredSettings
      attr_reader :settings
      def initialize(&block)
        @settings = {}
        instance_eval(&block) if block
      end

      def ip_address(name, options={})
        settings[name] = Setting.new(options)
      end

      def string(name, options={})
        settings[name] = Setting.new(options)
      end

      def number(name, options={})
        settings[name] = Setting.new(options)
      end
    end

    class << self

      # From homebrew / formula
      def self.attr_rw(*attrs)
        attrs.each do |attr|
          class_eval %Q{
          def #{attr}(val=nil)
            val.nil? ? @#{attr} : @#{attr} = val
          end
          }
        end
      end

      attr_rw :creator, :adapts_to, :website

      def implements(*devices)
        @implemented_devices ||= []
        @implemented_devices.concat(devices)
      end

      def settings &block
        return @registered_settings unless block_given?
        @registered_settings = RegisteredSettings.new(&block)
      end

      def requires_setup(setup_value=nil)
        return (@requires_setup || false) if setup_value.nil?
        @requires_setup = setup_value
      end
    end

    def setup?
      self.class.requires_setup ? setup_complete : true
    end

    def setup_complete
      @setup_complete || false
    end

    def settings
      @settings || {}
    end

    def settings=(hash)
      @settings = settings.merge!(hash)
    end

  end
end
