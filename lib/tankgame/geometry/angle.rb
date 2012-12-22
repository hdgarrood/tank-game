module TankGame
  module Geometry
    class Angle
      include Math

      def initialize(radians)
        @radians = normalize(radians)
      end

      def quadrant
        # don't worry, +between?+ is inclusive for floats
        if @radians.between? 0, PI/2
          :first
        elsif @radians.between? PI/2, PI
          :second
        elsif @radians.between? -PI, -PI/2
          :third
        else
          :fourth
        end
      end

      def direction
        if @radians.between? -PI/2, PI/2
          :right
        else
          :left
        end
      end

      def to_f
        @radians.to_f
      end

      private
      def normalize(angle)
        if angle < -PI
          normalize(angle + PI)
        elsif angle > PI
          normalize(angle - PI)
        else
          angle
        end
      end
    end
  end
end
