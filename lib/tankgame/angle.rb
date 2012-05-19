module TankGame
  class Angle
    include Math
    attr_reader :angle

    def self.normalize(angle)
      if angle < -PI
        self.normalize(angle + PI)
      elsif angle > PI
        self.normalize(angle - PI)
      else
        angle
      end
    end

    def initialize(angle)
      @angle = Angle.normalize(angle)
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
  end
end
