module TankGame
  module Geometry
    class Angle
      include Math
      attr_reader :angle

      def initialize(angle)
        @angle = normalize(angle)
      end

      def quadrant
        # don't worry, +between?+ is inclusive for floats
        if @angle.between? 0, PI/2
          :first
        elsif @angle.between? PI/2, PI
          :second
        elsif @angle.between? -PI, -PI/2
          :third
        else
          :fourth
        end
      end

      def direction
        if @angle.between? -PI/2, PI/2
          :right
        else
          :left
        end
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
