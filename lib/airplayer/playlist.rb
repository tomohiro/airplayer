module AirPlayer
  class Playlist < Array
    def initialize(options = {})
      @shuffle = options['shuffle'] || false
      @repeat  = options['repeat']  || false
    end

    def add(item)
      path = File.expand_path(item)
      Dir.exists?(path) ? concat(media_in(path)) : push(Media.new(item))
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
      def media_in(path)
        Dir.entries(path).sort.map do |node|
          Media.new(File.expand_path(node, path)) if Media.playable? node
        end.compact
      end
  end
end
