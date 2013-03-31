require 'rspec'
require 'pry'
require 'spirit'
require 'spirit_intent_listener'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
