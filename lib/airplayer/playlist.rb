module AirPlayer
  class Playlist < Array
    alias :entries :each

    def add(item)
      path = File.expand_path(item)
      if Dir.exists? path
        concat(media_in(path))
      else
        push(Media.new(item))
      end
      self
    end

    private
      def media_in(path)
        Dir.entries(path).map do |node|
          media_path = File.expand_path(node, path)
          Media.new(media_path) if File.file? media_path
        end.compact
      end
  end
end
