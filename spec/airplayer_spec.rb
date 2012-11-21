require 'spec_helper'

describe :AirPlayer do
  context :App do
    let(:app) { AirPlayer::App.new }

    it 'class type is Thor' do
      expect(app).to be_kind_of Thor
    end
  end

  context :Logger do
    it 'file path is /tmp/airplayer-access.log on Linux' do
      if RbConfig::CONFIG['target_os'] =~ /linux|unix/
        expect(AirPlayer::Logger.path).to eq '/tmp/airplayer-access.log'
      end
    end
  end

  context :Media do
    it 'check supported mime types' do
      expect(AirPlayer::Media.playable?('007 SKYFALL.mp4')).to be_true
      expect(AirPlayer::Media.playable?('007 SKYFALL.ts')).to be_true
      expect(AirPlayer::Media.playable?('007 SKYFALL.m4v')).to be_true
      expect(AirPlayer::Media.playable?('007 SKYFALL.mov')).to be_true
      expect(AirPlayer::Media.playable?('007 SKYFALL.ts')).to be_true
      expect(AirPlayer::Media.playable?('007 SKYFALL.flv')).to be_false
      expect(AirPlayer::Media.playable?('007 SKYFALL.wmv')).to be_false
      expect(AirPlayer::Media.playable?('.DS_Store')).to be_false
    end
    it 'give to local file' do
      media = AirPlayer::Media.new('./Gemfile')
      expect(media.file?).to be_true
    end
    it 'give to url' do
      media = AirPlayer::Media.new('http://example.com/video.mp4')
      expect(media.url?).to be_true
    end 
  end

  context :Playlist do
    let(:playlist) { AirPlayer::Playlist.new }

    it 'add URL to list, and that media type is url' do
      playlist.add('http://example.com/video.mp4')
      expect(playlist.first.path).to match 'http'
    end

    it 'add Podcast rss to list' do
      playlist.add('http://rss.cnn.com/services/podcasting/cnnnewsroom/rss.xml')
      playlist.entries do |media|
        expect(media).to be_kind_of AirPlayer::Media
      end
    end

    it 'add file to list, and that media type is file' do
      expect(playlist.add('./video.mp4').size).to eq 1
      expect(playlist.add('./video.m4v').size).to eq 2
    end

    it 'has list contains url or file path' do
      playlist.add('../airplayer')
      playlist.entries do |media|
        expect(media).to be_kind_of AirPlayer::Media
      end
    end
  end
end
