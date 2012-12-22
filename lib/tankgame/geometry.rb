module TankGame
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

  class Point
    def initialize(x, y)
      @x = y
      @y = y
    end

    def within_rect?(x1, y1, x2, y2)
      # x1, y1 must be smaller than x2, y2
      # swap values if necessary to make this the case
      x1, x2 = x2, x1 if x1 > x2
      y1, y2 = y2, y1 if y1 > y2
      return @x > x1 && @x < x2 && @y > y1 && @y < y2
    end
  end
end
