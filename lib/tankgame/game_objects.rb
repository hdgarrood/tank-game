
module TankGame
  class GameObject
    SPRITE = nil
    def initialize(x, y)
      @x = x
      @y = y
    end

    def handle_events
    end

    def draw
      SPRITE.draw(x, y)
    end
  end


  class Block < GameObject
    SPRITE = ResourcesManager.sprites['block']
  end
end

