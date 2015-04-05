# encoding: UTF-8
require 'fakefs/spec_helpers'
require 'spec_helper'

module AirPlayer
  describe Media do
    include FakeFS::SpecHelpers

    let (:media) do
      AirPlayer::Media
    end

    describe '#playable?' do
      context 'with supported mime types' do
        it 'returns true' do
          expect(media.playable?('007 SKYFALL.mp4')).to be true
          expect(media.playable?('007 SKYFALL.ts')).to be true
          expect(media.playable?('007 SKYFALL.m4v')).to be true
          expect(media.playable?('007 SKYFALL.mov')).to be true
          expect(media.playable?('007 SKYFALL.ts')).to be true
          expect(media.playable?('マルチ☆バイト.mp4')).to be true
        end
      end

      context 'with unsupported mime types' do
        it 'returns false' do
          expect(media.playable?('007 SKYFALL.flv')).to be false
          expect(media.playable?('007 SKYFALL.wmv')).to be false
          expect(media.playable?('NOT_PLAYABLE_FILE')).to be false
        end
      end

      context 'with urls' do
        it 'delegates to YoutubeDl' do

          expect(YoutubeDl).to receive(:supports?)
                                          .with('http://example.com/video.mp4').and_return(true)
          expect(media.playable?('http://example.com/video.mp4')).to be

          expect(YoutubeDl).to receive(:supports?)
                                          .with('http://example.com/not-video').and_return(false)
          expect(media.playable?('http://example.com/not-video')).not_to be
        end
      end
    end

    describe '.file?' do
      context 'with given local file' do
        it 'returns true' do
          FileUtils.touch('fake_movie.m4v')
          expect(media.new('fake_movie.m4v').file?).to be true
        end
      end
    end

    describe '.url?' do
      context 'with given URL' do
        before { allow(YoutubeDl).to receive(:enabled?).and_return(false) }

        it 'returns true' do
          expect(media.new('http://example.com/video.mp4').url?).to be true
        end
      end
    end
  end
end
