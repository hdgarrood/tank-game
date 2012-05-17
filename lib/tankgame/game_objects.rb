module TankGame
  class GameObject
    attr_reader :x, :y

    def initialize(x, y)
      @sprite = nil
      @x = x
      @y = y
    end

    def handle_events
    end

    def do_logic
    end

    def draw
      @sprite.draw(x, y, 0)
    end
  end


  class Block < GameObject
    def initialize(x, y)
      super(x, y)
      @sprite = $window.resources.sprites['block']
    end
  end
end

