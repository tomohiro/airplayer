require 'rubygems'
require 'airplayer/version'

module AirPlayer
  LOG_PATH = '/var/log/airplayer.log'

  autoload :App,    'airplayer/app'
  autoload :Player, 'airplayer/player'
  autoload :Server, 'airplayer/server'
end
