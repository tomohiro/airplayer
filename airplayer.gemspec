# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airplayer/version'

Gem::Specification.new do |spec|
  spec.name          = 'airplayer'
  spec.version       = AirPlayer::VERSION
  spec.authors       = ['Tomohiro TAIRA']
  spec.email         = ['tomohiro.t@gmail.com']
  spec.description   = 'Command-line AirPlay video client for Apple TV'
  spec.summary       = 'Command-line AirPlay video client for Apple TV'
  spec.homepage      = 'https://github.com/Tomohiro/airplayer'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'ruby-progressbar'
  spec.add_runtime_dependency 'airplay', '~> 0.2.9'
  spec.add_runtime_dependency 'rack'
  spec.add_runtime_dependency 'mime-types'
  spec.add_runtime_dependency 'nokogiri'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'coveralls'
end
