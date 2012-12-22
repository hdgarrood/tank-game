require 'gosu'
require 'tankgame/level_parser'
require 'tankgame/geometry'
require 'tankgame/background_drawing'

module TankGame
  module State
    class Base
      include BackgroundDrawing

      def initialize
        @objects = []
      end

      def update
        @objects.each do |o|
          o.handle_events
          o.do_logic
        end
      end

      def draw
        draw_background($window)
        @objects.each(&:draw)
        if uses_crosshair_cursor?
          cursor = $window.resources.sprites[:crosshair_cursor]
          cursor.draw($window.mouse_x - (cursor.width / 2),
                      $window.mouse_y - (cursor.height / 2), 0)
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

    class Game < Base
      def initialize
        super
        @objects = LevelParser.parse('one')
      end

      def uses_crosshair_cursor?
        true
      end
    end
  end
end

