require 'spec_helper'

module AirPlayer
  describe Media do
    subject { AirPlayer::Media }

    context 'valid mime types' do
      its 'supported' do
        expect(subject.playable?('007 SKYFALL.mp4')).to be_true
        expect(subject.playable?('007 SKYFALL.ts')).to be_true
        expect(subject.playable?('007 SKYFALL.m4v')).to be_true
        expect(subject.playable?('007 SKYFALL.mov')).to be_true
        expect(subject.playable?('007 SKYFALL.ts')).to be_true
      end
    end

    context 'invalid mime types' do
      its 'unsupported' do
        expect(subject.playable?('007 SKYFALL.flv')).to be_false
        expect(subject.playable?('007 SKYFALL.wmv')).to be_false
        expect(subject.playable?('.DS_Store')).to be_false
      end
    end

    context 'give to' do
      it 'Gemfile' do
        media = subject.new('./Gemfile')
        expect(media.file?).to be_true
      end

      it 'URL' do
        media = subject.new('http://example.com/video.mp4')
        expect(media.url?).to be_true
      end

      it 'YouTube URL' do
        media = subject.new('http://www.youtube.com/watch?v=gVNYm9Qncyc')
        expect(media.url?).to be_true
      end
    end
  end
end
