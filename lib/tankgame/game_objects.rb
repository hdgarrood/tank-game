
module TankGame
  class GameObject
    def initialize(sprite)
      @sprite = sprite
    end
  end


  class Block < GameObject
    def initialize(sprite, x, y)
      @window = window
      @x = x
      @y = y
    end

    def handle_events
    end

    def draw
      @sprite.draw(x*20, y*20) 
    end
  end
end

