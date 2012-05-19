module TankGame
  class Angle
    include Math
    attr_reader :angle

    def initialize(angle)
      if angle <= PI && angle >= -PI
        @angle = angle
      end
    end

    def quadrant
      # don't worry, +between?+ is inclusive for floats
      if @angle.between? 0, PI/2
        :first
      elsif @angle.between? PI/2, PI
        :second
      elsif @angle.between? 0, -PI/2
        :third
      else
        :fourth
      end
    end
  end
end
