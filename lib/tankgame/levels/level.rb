module TankGame
  module Levels
    module Level
      def construct
        objects.map do |klass, *args|
          klass.new(*args)
        end
      end
    end
  end
end
