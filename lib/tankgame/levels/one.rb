require 'tankgame/game_objects'
require 'tankgame/levels/level'

module TankGame
  module Levels
    module One
      extend Level
      include GameObjects

      def self.objects
        [
          [Player, 64, 300],
          [Block, 0, 448],
          [Block, 32, 448],
          [Block, 64, 448],
          [Block, 96, 448],
          [Block, 128, 448],
          [Block, 160, 448],
          [Block, 192, 448],
          [Block, 224, 448],
          [Block, 256, 448],
          [Block, 288, 448],
          [Block, 320, 448],
          [Block, 352, 448],
          [Block, 384, 448],
          [Block, 416, 448],
          [Block, 448, 448],
          [Block, 480, 448],
          [Block, 512, 448],
          [Block, 544, 448],
          [Block, 576, 448],
          [Block, 608, 448],
          [Block, 640, 448],
          [Block, 352, 416],
          [Block, 352, 384]
        ]
      end
    end
  end
end
