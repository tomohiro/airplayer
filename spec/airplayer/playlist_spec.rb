require 'spec_helper'

module AirPlayer
  describe Playlist do
    subject { AirPlayer::Playlist.new }

    describe '#add' do
      context 'url' do
        before { subject.add('http://example.com/video.mp4') }
        it 'media type is url' do
          expect(subject.first.path).to match 'http'
        end
      end

      context 'Podcast RSS' do
        it do
          subject.add('http://rss.cnn.com/services/podcasting/cnnnewsroom/rss.xml')
          subject.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
          end
        end
      end

      context 'multiple files' do
        it 'have multiple files' do
          expect(subject.add('./video.mp4').size).to eq 1
          expect(subject.add('./video.m4v').size).to eq 2
        end
      end

      context 'local file' do
        it 'type is Media' do
          subject.add('../airplayer')
          subject.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
          end
        end
      end
    end
  end
end
