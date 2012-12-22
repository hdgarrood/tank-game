module TankGame
  module Geometry
    class Angle
      include Comparable
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
        elsif @radians.between? PI, 3*PI/2
          :third
        else
          :fourth
        end
      end

      def direction
        if [:first, :fourth].include?(quadrant)
          :right
        else
          :left
        end
      end

      def to_f
        @radians.to_f
      end

      def +(other)
        Angle.new(to_f + other.to_f)
      end

      def -(other)
        Angle.new(to_f - other.to_f)
      end

      def <=>(other)
        to_f <=> other.to_f
      end

      def to_gosu
        to_f.radians_to_gosu
      end

      private
      def normalize(angle)
        if angle < 0
          normalize(angle + 2*PI)
        elsif angle > 2*PI
          normalize(angle - 2*PI)
        else
          angle.to_f
        end
      end
    end
  end
end
