# encoding: utf-8
require File.expand_path('../lib/airplayer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Tomohiro, TAIRA']
  gem.email         = ['tomohiro.t@gmail.com']
  gem.description   = %q{Command-line AirPlay video client}
  gem.summary       = %q{Command-line AirPlay video client}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'airplayer'
  gem.require_paths = ['lib']
  gem.version       = AirPlayer::VERSION

  gem.add_runtime_dependency 'ruby-progressbar'
  gem.add_runtime_dependency 'airplay'
end
