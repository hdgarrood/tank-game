require 'tankgame/level_parser'

module TankGame
  module State
    class Base
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
        @objects.each do |o|
          o.draw
        end
        if uses_special_cursor?
          $window.resources.sprites[:cursor].draw($window.mouse_x,
                                                  $window.mouse_y, 0)
        end
      end
    end

    class Game < Base
      def initialize
        @objects = LevelParser.parse('one')
      end

      def uses_special_cursor?
        true
      end
    end
  end
end

