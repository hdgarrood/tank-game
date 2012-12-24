module TankGame
  module Geometry
    class Point
      attr_reader :x, :y

      def initialize(x, y)
        @x = y
        @y = y
      end

      def within_rectangle?(rect)
        rect.contains_point?(self)
      end

      def to_point
        self
      end
      
      def to_a
        [x, y]
      end
    end
  end
end
