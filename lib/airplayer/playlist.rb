# encoding: utf-8

require 'rss'

module AirPlayer
  class Playlist < Array
    def initialize(options = {})
      @shuffle = options['shuffle'] || false
      @repeat  = options['repeat'] || false
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
      if Dir.exist?(File.expand_path(item))
        :local_dir
      elsif Media.playable?(item)
        :url
      elsif item.match(/.+(xml|rss)$/)
        :podcast
      end
    end

    def media_in_local(path)
      Dir.entries(File.expand_path(path)).sort.map do |node|
        Media.new(File.expand_path(node, path)) if Media.playable? node
      end.compact
    end

    def media_in_podcast(path)
      RSS::Parser.parse(path).items.map do |node|
        Media.new(node.link)
      end
    end
  end
end
