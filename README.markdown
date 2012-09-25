AirPlayer
================================================================================

Command-line AirPlay video client for AppleTV

[![Build Status](https://secure.travis-ci.org/Tomohiro/airplayer.png)](https://secure.travis-ci.org/Tomohiro/airplayer)
[![Dependency Status](https://gemnasium.com/Tomohiro/airplayer.png)](https://gemnasium.com/Tomohiro/airplayer)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/Tomohiro/airplayer)
[![endorse](http://api.coderwall.com/tomohiro/endorsecount.png)](http://coderwall.com/tomohiro)


---


Requirements
-------------------------------------------------------------------------------

- Ruby 1.9.2 or later
- AppleTV 2G or later


### Ubuntu

```sh
$ sudo apt-get install rdnssd libavahi-compat-libdnssd-dev
```


Installation
--------------------------------------------------------------------------------

### RubyGems

```sh
$ gem install airplayer
```

### Bundler

```sh
$ git clone git://github.com/Tomohiro/airplayer.git
$ cd airplayer
$ bundle install --path vendor/bundle
```


Usage
--------------------------------------------------------------------------------

### Play online video

```sh
$ airplayer play http://example.com/my-video.mp4
AirPlay: http://example.com/my-video.mp4 to Apple TV(10.0.1.18)
   Time: 00:00:31 |==============================================| 100% Complete
```

### Play local video

```sh
$ airplayer play $HOME/Movies/video.mp4
AirPlay: http://10.0.1.13:7070 to Apple TV(10.0.1.18)
   Time: 00:00:31 |==============================================| 100% Complete
```


LICENSE
--------------------------------------------------------------------------------

&copy; 2012 Tomohiro, TAIRA.
This project is licensed under the MIT license.
See LICENSE for details.
