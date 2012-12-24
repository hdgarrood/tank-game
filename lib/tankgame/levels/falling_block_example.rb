require 'tankgame/game_objects'
require 'tankgame/levels/level'

module TankGame
  module Levels
    module FallingBlockExample
      extend Level
      include GameObjects

      def self.objects
        [
          [FallingBlock, 0, 0],
          [Block, 0, 300]
        ]
      end
    end
  end
end
