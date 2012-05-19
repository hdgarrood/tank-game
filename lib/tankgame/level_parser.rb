module TankGame
  class LevelParser
    class << self
      def parse(level)
        objects = []
        objectmap = []

        0.upto($window.width - 1) do |i|
          objectmap[i] = []
          0.upto($window.height - 1) do |j|
            objectmap[i][j] = nil
          end
        end

        lines = File.open(File.join('levels', level)) { |f| f.readlines }
        lines.each do |line|
          # each line is of the form:
          #   [ObjectClass, arg1, arg2, ...]
          # where arg1, arg2, etc are parameters for their constructors
          array = eval line
          if array
            klass, x, y, *args = array
            object = klass.new(x, y, *args)
            objects << object
            x.upto(x + object.width) do |i|
              y.upto(y + object.height) do |j|
                if i < $window.width && j < $window.height
                  objectmap[i][j] = object 
                end
              end
            end
          end
        end
        return objects, objectmap
      end
    end
  end
end

