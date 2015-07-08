AirPlayer
================================================================================

Command-line AirPlay video client for Apple TV

[![Stillmaintained](http://stillmaintained.com/Tomohiro/airplayer.png)](http://stillmaintained.com/Tomohiro/airplayer)
[![Gem Version](https://img.shields.io/gem/v/airplayer.svg?style=flat-square)](http://badge.fury.io/rb/airplayer)
[![Dependency Status](https://img.shields.io/gemnasium/Tomohiro/airplayer.svg?style=flat-square)](https://gemnasium.com/Tomohiro/airplayer)
[![Build Status](https://img.shields.io/travis/Tomohiro/airplayer.svg?style=flat-square)](https://travis-ci.org/Tomohiro/airplayer)
[![Coverage Status](https://img.shields.io/coveralls/Tomohiro/airplayer.svg?style=flat-square)](https://coveralls.io/r/Tomohiro/airplayer)
[![Code Climate](https://img.shields.io/codeclimate/github/Tomohiro/airplayer.svg?style=flat-square)](https://codeclimate.com/github/Tomohiro/airplayer)


---


Requirements
-------------------------------------------------------------------------------

- OS X, Ubuntu, Arch Linux
- Ruby 1.9.3, 2.1, 2.2 or later
- Bundler 1.10.0 or later
- AppleTV 2G or later
- [youtube-dl](http://rg3.github.com/youtube-dl/) (If you want to watch YouTube)

### For Arch Linux

[nss-mdns](https://www.archlinux.org/packages/extra/x86_64/nss-mdns/) package is required.

```sh
$ sudo pacman -S nss-mdns
```
or

```sh
$ yaourt -S nss-mdns
```

### For Ubuntu

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
$ bundle install --deployment
```


Usage
--------------------------------------------------------------------------------

### Play online video

```sh
$ airplayer play http://heinlein.local/Movies/AKIRA.m4v

 Source: http://heinlein.local/misc/Movies/AKIRA.m4v
  Title: AKIRA.m4v
 Device: Apple TV (10.0.1.2)
   Time: 00:04:25 |=                                              | 3% Streaming
```

### Play video

```sh
$ airplayer play '~/Movies/Trailers/007 SKYFALL.mp4'

 Source: http://10.0.1.6:7070
  Title: SKYFALL.mp4
 Device: Apple TV (10.0.1.2)
   Time: 00:00:20 |=====                                         | 11% Streaming
```

### Play all video in specific directory

```sh
$ airplayer play ~/Movies/Trailers

 Source: http://10.0.1.6:7070
  Title: 007 Casino Royale.mp4
 Device: Apple TV (10.0.1.2)
   Time: 00:02:33 |==============================================| 100% Complete

 Source: http://10.0.1.6:7070
  Title: 007 Quantum Of Solace.mp4
 Device: Apple TV (10.0.1.2)
   Time: 00:02:01 |==============================================| 100% Complete

 Source: http://10.0.1.6:7070
  Title: 007 SKYFALL.mp4
 Device: Apple TV (10.0.1.2)
   Time: 00:02:36 |==============================================| 100% Complete
```

### Play video podcast XML

Example: CNN video podcast

```sh
$ airplayer play http://rss.cnn.com/services/podcasting/cnnnewsroom/rss.xml

 Source: http://rss.cnn.com/~r/services/podcasting/cnnnewsroom/rss/~5/z7DirHubdP0/exp-travel-insider-hilton-head-island.cnn.m4v
  Title: exp-travel-insider-hilton-head-island.cnn.m4v
 Device: Apple TV (10.0.1.2)
   Time: 00:00:44 |============                                  | 39% Streaming
```


### Play YouTube video

```sh
$ airplayer play 'http://www.youtube.com/watch?v=QH2-TGUlwu4'
```


### Repeat play

Repeat one

```sh
$ airplayer play '~/Movies/Trailers/007 SKYFALL.mp4' --repeat
```

Repeat all

```sh
$ airplayer play '~/Movies/Trailers' --repeat
```


### Shuffle play

```sh
$ airplayer play '~/Movies/Trailers' --shuffle
```


### Select Device

If you have multiple "AirPlay" devices, specifying the device number for the following play is available on any device.

Check the AirPlay device number

```sh
$ airplayer devices
0: John's Apple TV (10.0.1.2:7000) # John's Apple TV number is 0
1: Jane's Apple TV (10.0.1.3:7000) # Jane's Apple TV number is 1
```

Use `--device` or `-d` options

```sh
$ airplayer play --device 1 '~/Movies/GHOST IN THE SHELL.mp4'
```


Advanced Usage
--------------------------------------------------------------------------------

### Register to OS X Service

You can create Automator Service, that opens URL from your browser in airplayer.

![automator service](https://cloud.githubusercontent.com/assets/154571/6997755/aa2599e8-dbc8-11e4-8cc4-9671d9cd8ad7.png)


Supported MIME types
--------------------------------------------------------------------------------

[AirPlay Overview - Configuring Your Server](http://developer.apple.com/library/ios/#documentation/AudioVideo/Conceptual/AirPlayGuide/PreparingYourMediaforAirPlay/PreparingYourMediaforAirPlay.html)

File extension | MIME type       | Ruby `mime-types`
-------------- | --------------- | -----------------------------
.ts            | video/MP2T      | video/mp2t
.mov           | video/quicktime | video/quicktime
.m4v           | video/mpeg4     | video/m4v
.mp4           | video/mpeg4     | application/mp4, video/mp4


LICENSE
--------------------------------------------------------------------------------

&copy; 2012 - 2015 Tomohiro TAIRA.
This project is licensed under the MIT license.
See LICENSE for details.
