module TankGame
  class LevelParser
    class << self
      def parse(level)
        objects = []
        lines = File.open(File.join('levels', level)) { |f| f.readlines }
        lines.each do |line|
          # each line is of the form:
          #   [ObjectClass, arg1, arg2, ...]
          # where arg1, arg2, etc are parameters for their constructors
          array = eval line
          if array
            klass, *args = array
            objects << klass.new(*args)
          end
        end
        return objects
      end
    end
  end
end

