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
      end
    end

    class Game < Base
      def initialize
        @objects = LevelParser.parse('one')
      end
    end
  end
end

