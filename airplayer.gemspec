# encoding: utf-8
require File.expand_path('../lib/airplayer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'airplayer'
  gem.version       = AirPlayer::VERSION
  gem.authors       = ['Tomohiro, TAIRA']
  gem.email         = ['tomohiro.t@gmail.com']
  gem.description   = %q{Command-line AirPlay video client for AppleTV}
  gem.summary       = %q{Command-line AirPlay video client for AppleTV}
  gem.homepage      = 'https://github.com/Tomohiro/airplayer'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'thor'
  gem.add_runtime_dependency 'ruby-progressbar'
  gem.add_runtime_dependency 'airplay'
  gem.add_runtime_dependency 'rack'

  gem.add_development_dependency 'rspec'
end
