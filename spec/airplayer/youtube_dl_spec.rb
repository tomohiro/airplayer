# encoding: UTF-8
require 'fakefs/spec_helpers'
require 'spec_helper'

module AirPlayer
  describe YoutubeDl do

    YOUTUBE_URL = 'http://www.youtube.com/watch?v=QH2-TGUlwu4'.freeze
    STREAMCZ_URL = 'https://www.stream.cz/vesele-velikonoce/10005380-nadiwich'

    it 'supports StreamCZ' do
      expect(subject.supports?(STREAMCZ_URL)).to be
    end

    it 'supports youtube' do
      expect(subject.supports?(YOUTUBE_URL)).to be
    end

    it 'gets title' do
      expect(subject.get_title(YOUTUBE_URL)).to eq('Nyan Cat [original]')
    end

    it 'gets url' do
      expect(subject.get_url(YOUTUBE_URL)).to match(/.googlevideo.com/)
    end

    it 'gets filename' do
      expect(subject.get_filename(YOUTUBE_URL)).to match(/Nyan Cat \[original\]-.+\.mp4/)
    end
  end
end
