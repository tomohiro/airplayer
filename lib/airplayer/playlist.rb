# encoding: utf-8

require 'rss'
require 'nokogiri'

module AirPlayer
  class Playlist < Array
    def initialize(options = {})
      @shuffle = options['shuffle'] || false
      @repeat  = options['repeat']  || false
    end

    def add(item)
      case type(item)
      when :local_dir
        concat(media_in_local(item))
      when :podcast
        concat(media_in_podcast(item))
      when :url
        push(Media.new(item))
      end
      self
    end

    def entries(&blk)
      loop do
        shuffle! if @shuffle
        send(:each, &blk)
        break unless @repeat
      end
    end

    private
      def type(item)
        if Dir.exists?(File.expand_path(item))
          :local_dir
        elsif Media.playable? item
          :url
        elsif RSS::Parser.parse(open(item))
          :podcast
        end
      end

      def media_in_local(path)
        Dir.entries(File.expand_path(path)).sort.map do |node|
          Media.new(File.expand_path(node, path)) if Media.playable? node
        end.compact
      end

      def media_in_podcast(path)
        Nokogiri::XML(open(path)).search('enclosure').map do |node|
          Media.new(node.attributes['url'].text)
        end
      end
  end
end
