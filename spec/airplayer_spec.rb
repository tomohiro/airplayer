require 'spec_helper'

describe :AirPlayer do
  let(:app) { AirPlayer::App.new }

  context :App do
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
    it 'give to local file' do
      media = AirPlayer::Media.new('./Gemfile')
      expect(media.type).to eq :file
    end
    it 'give to url' do
      media = AirPlayer::Media.new('http://example.com/video.mp4')
      expect(media.type).to eq :url
    end 
  end

  context :Playlist do
    let(:playlist) { AirPlayer::Playlist.new }

    it 'add URL to list, and that is match http://..' do
      expect(playlist.add('http://example.com/video.mp4').first.path).to match 'http'
    end

    it 'add file to list, and that is match /airplayer/' do
      expect(playlist.add('./LICENSE').size).to eq 1
      expect(playlist.add('./Gemfile').size).to eq 2
    end

    it 'has list contains url or file path' do
      playlist.add('../airplayer')
      playlist.entries do |media|
        expect(media).to be_kind_of AirPlayer::Media
      end
    end
  end
end
