module AirPlayer
  class Playlist < Array
    alias :entries :each

    def add(item)
      path = File.expand_path(item)
      Dir.exists?(path) ? concat(media_in(path)) : push(Media.new(item))
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
