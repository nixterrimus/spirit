require 'securerandom'

require "spirit/version"
require "spirit/adapter"
require "spirit/capability"
require "spirit/device"
require "spirit/devices"

module Spirit
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    #attr_accessor :mailer_sender

    def initialize
      #@mailer_sender = 'donotreply@example.com'
    end
  end
end
