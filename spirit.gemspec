# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spirit/version'

Gem::Specification.new do |gem|
  gem.name          = "spirit"
  gem.version       = Spirit::VERSION
  gem.authors       = ["Nick Rowe"]
  gem.email         = ["nixterrimus@dcxn.com"]
  gem.description   = %q{Spirit is a personal internet of things manager & Automation ghost}
  gem.summary       = gem.description
  gem.homepage      = "http://dcxn.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "moneta"
  gem.add_runtime_dependency "toystore"
  gem.add_runtime_dependency "celluloid"
  gem.add_runtime_dependency "redis"
  gem.add_runtime_dependency 'sucker_punch'
  gem.add_runtime_dependency 'active_model_serializers'
  gem.add_runtime_dependency 'commander'

  # Server Requirements
  gem.add_runtime_dependency 'sinatra'

  # Added for hue_adapter, to remove when hue adapter
  #  is broken out
  gem.add_runtime_dependency 'huey'
  gem.add_runtime_dependency 'color-tools'

  gem.add_development_dependency "rspec", "~> 2.6"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
end
