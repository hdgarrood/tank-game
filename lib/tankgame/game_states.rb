require 'gosu'
require 'tankgame/level_parser'
require 'tankgame/geometry'
require 'tankgame/background_drawing'

module TankGame
  module State
    class Base
      extend BackgroundDrawing

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
        [x, y].each do |arg|
          fail "can't pass non-numeric value #{arg} to collided_with" unless arg.is_a? Numeric
        end
        test_obj.x = x
        test_obj.y = y

        @objects.each do |o|
          next if !o.is_a? klass
          test_obj.four_corners.each do |x, y|
            return true if Point.new(x, y).within_rect?(*o.two_corners.flatten)
          end
        end
        return false
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

