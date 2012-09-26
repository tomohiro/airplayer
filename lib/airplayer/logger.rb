require 'rbconfig'

module AirPlayer
  class Logger
    def self.path
      case RbConfig::CONFIG['target_os']
      when /darwin|osx/i
        File.expand_path('~/Library/Logs/airplayer-access.log')
      when /linux|unix/i
        '/tmp/airplayer-access.log'
      when /mswin|windows|cygwin/i
        'NUL'
      else
        STDOUT
      end
    end
  end
end
