require 'tankgame/levels/one'
require 'tankgame/levels/falling_block_example'

module TankGame
  module States
    class Game < Base
      def initialize
        super
        @objects = Levels::One.construct
      end

      def uses_crosshair_cursor?
        true
      end
    end
  end
end

