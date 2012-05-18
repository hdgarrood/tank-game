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

  class Player < GameObject
    def initialize(x, y)
      super(x, y)
      @sprites = {
        :tank => $window.resources.sprites['player'],
        :barrel_l => $window.resources.sprites['barrel_left'],
        :barrel_r => $window.resources.sprites['barrel_right']
      }
    end

    def draw
      @sprites[:tank].draw(x, y, 0)
    end
  end
end

