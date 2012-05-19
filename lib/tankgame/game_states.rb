require 'gosu'
require 'tankgame/level_parser'

module TankGame
  module State
    class Base
      def initialize
        @bottom_colour = Gosu::Color.argb(0xff6b6b6b)
        @top_colour = Gosu::Color.argb(0xfff0f0f0)
        @objects = []
      end

      def update
        @objects.each do |o|
          o.handle_events
          o.do_logic
        end
      end

      def draw
        draw_background
        @objects.each do |o|
          o.draw
        end
        if uses_special_cursor?
          cursor = $window.resources.sprites[:cursor]
          cursor.draw($window.mouse_x - (cursor.width / 2),
                      $window.mouse_y - (cursor.height / 2), 0)
        end
      end

      private
      def draw_background
        $window.draw_quad(0, 0, @top_colour,
                          $window.width, 0, @top_colour,
                          0, $window.height, @bottom_colour,
                          $window.width, $window.height, @bottom_colour,
                          0)
      end
    end

    class Game < Base
      def initialize
        super
        @objects = LevelParser.parse('one')
      end

      def uses_special_cursor?
        true
      end
    end
  end
end

