require 'tankgame/game_objects'
require 'tankgame/levels/level'

module TankGame
  module Levels
    module One
      extend Level
      include GameObjects

      def self.objects
        [
          [Player, 64, 30],
          [Block, 0, 120],
          [Block, 32, 120],
          [Block, 64, 120],
          [Block, 96, 120],
          *(1..19).map do |i|
            [Block, 32*i + 96, 32*i + 120]
          end
        ]
      end
    end
  end
end
