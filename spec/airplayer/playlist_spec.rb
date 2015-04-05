require 'fakefs/spec_helpers'
require 'spec_helper'

module AirPlayer
  describe Playlist do
    include FakeFS::SpecHelpers

    let (:playlist) do
      AirPlayer::Playlist.new
    end

    # works even without this, but it prevents connecting to internet
    before{ allow(YoutubeDl).to receive(:enabled?).and_return(false) }

    describe '.add' do
      context 'with local directory' do
        it 'returns media type is local file' do
          FakeFS do
            FileUtils.touch('01.m4v')
            FileUtils.touch('02.m4v')
          end

          playlist.add('.')
          playlist.entries do |media|
            expect(media.file?).to be true
          end
        end
      end

      context 'with URL' do
        it 'returns media type is url' do
          playlist.add('http://example.com/video.mp4')
          expect(playlist.first.path).to match 'http'
        end
      end

      context 'with multiple files' do
        it 'have multiple files' do
          FakeFS do
            FileUtils.touch('video.m4v')
            FileUtils.touch('video.mp4')
          end

          expect(playlist.add('video.mp4').size).to eq 1
          expect(playlist.add('video.m4v').size).to eq 2
        end
      end

      context 'with podcast RSS' do
        before { FileUtils.mkpath(Dir.tmpdir) }

        it 'returns media instances' do
          playlist.add('http://rss.cnn.com/services/podcasting/cnnnewsroom/rss.xml')
          playlist.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
          end
        end
      end

      context 'with local file' do
        it 'returns media instances' do
          FakeFS do
            FileUtils.touch('video.mp4')
          end

          playlist.add('video.mp4')
          playlist.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
          end
        end
      end

      context 'with stream url' do
        it 'returns media instances' do
          playlist.add('https://www.stream.cz/vesele-velikonoce/10005380-nadiwich')
          playlist.entries do |media|
            expect(media).to be_kind_of AirPlayer::Media
            expect(media.type).to eq(:url)
          end
        end
      end
    end
  end
end
