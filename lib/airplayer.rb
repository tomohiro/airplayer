require 'rubygems'
require 'airplayer/version'

module AirPlayer
  autoload :Logger,     'airplayer/logger'
  autoload :App,        'airplayer/app'
  autoload :Controller, 'airplayer/controller'
  autoload :Server,     'airplayer/server'
  autoload :Playlist,   'airplayer/playlist'
  autoload :Media,      'airplayer/media'
end
