require 'spec_helper'

module AirPlayer
  describe Media do
    subject { AirPlayer::Media }

    context 'valid mime types' do
      it 'supported' do
        expect(subject.playable?('007 SKYFALL.mp4')).to be_true
        expect(subject.playable?('007 SKYFALL.ts')).to be_true
        expect(subject.playable?('007 SKYFALL.m4v')).to be_true
        expect(subject.playable?('007 SKYFALL.mov')).to be_true
        expect(subject.playable?('007 SKYFALL.ts')).to be_true
      end
    end

    context 'invalid mime types' do
      it 'unsupported' do
        expect(subject.playable?('007 SKYFALL.flv')).to be_false
        expect(subject.playable?('007 SKYFALL.wmv')).to be_false
        expect(subject.playable?('.DS_Store')).to be_false
      end
    end

    context 'give Gemfile' do
      it 'file' do
        media = subject.new('./Gemfile')
        expect(media.local?).to be_true
      end
    end

    context 'give URL' do
      it 'URL' do
        media = subject.new('http://example.com/video.mp4')
        expect(media.title).to match(/video/)
        expect(media.video?).to be_true
        expect(media.local?).to be_false
      end
    end

    context 'give YouTube URL' do
      it 'has title and url' do
        media = subject.new('http://www.youtube.com/watch?v=gVNYm9Qncyc')
        expect(media.title).to match(/Mogwai/)
        expect(media.video?).to be_true
        expect(media.local?).to be_false
      end

      it 'has title and short url' do
        media = subject.new('http://youtu.be/gVNYm9Qncyc')
        expect(media.title).to match(/Mogwai/)
        expect(media.video?).to be_true
        expect(media.local?).to be_false
      end
    end
  end
end
