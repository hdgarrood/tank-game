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
      def collided_with?(obj, klass, x, y)
        test_obj = obj.dup
        test_obj.x = x.to_f
        test_obj.y = y.to_f

        @objects.any? do |o|
          !o.is_a?(klass) && test_obj.overlap?(o)
        end
      end
    end
  end
end
