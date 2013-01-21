require 'securerandom'

require "spirit/version"
require "spirit/poolable"
require "spirit/adapter"
require "spirit/adapters"
require "spirit/capability"
require "spirit/device"
require "spirit/devices"

module Spirit
  class << self
    attr_accessor :configuration, :devices, :adapters
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.devices
    @devices ||= Devices.new
  end

  def self.adapters
    @adapters ||= Adapters.new
  end

  class Configuration
    #attr_accessor :mailer_sender

    def initialize
      #@mailer_sender = 'donotreply@example.com'
    end
  end
end
