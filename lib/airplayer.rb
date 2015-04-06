require 'airplay'
Airplay.configuration.load

module AirPlayer
  require 'airplayer/version'
  require 'airplayer/controller'
  require 'airplayer/device'
  require 'airplayer/playlist'
  require 'airplayer/media'
  require 'airplayer/youtube_dl'

  require 'airplayer/app'
end
