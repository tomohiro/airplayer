# encoding: UTF-8
require 'spec_helper'

module AirPlayer
  describe Media do
    let (:media) { AirPlayer::Media }

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
          expect(media.playable?('.DS_Store')).to be false
        end
      end
    end

    describe '.file?' do
      context 'with given local file' do
        it 'returns true' do
          expect(media.new('./Gemfile').file?).to be true
        end
      end
    end

    describe '.url?' do
      context 'with given URL' do
        it 'returns true' do
          expect(media.new('http://example.com/video.mp4').url?).to be true
        end
      end
    end
  end
end
