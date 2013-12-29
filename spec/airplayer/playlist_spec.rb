require 'spec_helper'

module AirPlayer
  describe Playlist do
    let (:playlist) do
      AirPlayer::Playlist.new
    end

    describe '.add' do
      context 'with URL' do
        it 'return media type is url' do
          playlist.add('http://example.com/video.mp4')
          expect(playlist.first.path).to match 'http'
        end
      end

      context 'with multiple files' do
        it 'have multiple files' do
          expect(playlist.add('./video.mp4').size).to eq 1
          expect(playlist.add('./video.m4v').size).to eq 2
        end
      end

      context 'with podcast RSS' do
        it 'returns media instances' do
          playlist.add('http://rss.cnn.com/services/podcasting/cnnnewsroom/rss.xml')
          playlist.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
          end
        end
      end

      context 'with local file' do
        it 'returns media instances' do
          playlist.add('../video.mp4')
          playlist.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
          end
        end
      end
    end
  end
end
