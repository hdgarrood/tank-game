require 'tankgame/background_drawing'
require 'tankgame/mouse'

module TankGame
  module States
    class Base
      include TankGame::BackgroundDrawing

      def initialize
        @objects = []
      end

      def update
        @objects.each(&:handle_events).each(&:do_logic)
      end

      def draw
        draw_background($window)
        @objects.each(&:draw)
        if uses_crosshair_cursor?
          cursor = Resources.sprites[:crosshair_cursor]
          cursor.draw(Mouse.x - (cursor.width / 2),
                      Mouse.y - (cursor.height / 2), 0)
        end
      end

      # returns true if +obj+ placed at +x+, +y+ collides with an
      # instance of +klass+, else returns false
      def collisions_with(obj, klass)
        @objects.select do |o|
          !o.equal?(obj) &&       # objects shouldn't collide with themselves
            o.is_a?(klass) &&     # must be of the given class
            obj.overlap?(o)       # must be colliding
        end
      end

      def add_game_object(obj)
        @objects << obj
        nil
      end
    end
  end
end
