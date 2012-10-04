module AirPlayer
  class Playlist < Array
    alias :entries :each

    def add(item)
      path = File.expand_path(item)
      if local_path?(path)
        directory?(path) ? concat(files_in(path)) : push(path)
      else
        push(item)
      end
      self
    end

    private
      def local_path?(path)
        File.exist? path
      end

      def directory?(path)
        Dir.exists? path
      end

      def files_in(path)
        return [] unless Dir.exists? path
        Dir.entries(path).map do |node|
          File.expand_path(node) if File.file? node
        end.compact
      end
  end
end
