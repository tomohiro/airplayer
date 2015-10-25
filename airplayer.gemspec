# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airplayer/version'

Gem::Specification.new do |spec|
  spec.name          = 'airplayer'
  spec.version       = AirPlayer::VERSION
  spec.authors       = ['Tomohiro TAIRA']
  spec.email         = ['tomohiro.t@gmail.com']

  spec.summary       = 'Command-line AirPlay video client for Apple TV'
  spec.description   = 'Command-line AirPlay video client for Apple TV'
  spec.homepage      = 'https://github.com/Tomohiro/airplayer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'ruby-progressbar'

  spec.add_runtime_dependency 'airplay', '~> 1.0.2'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'pry'
end
