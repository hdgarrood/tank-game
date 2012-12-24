module TankGame
  module GameObjects
    module AffectedByGravity
      def gravity
        0.5 # pixels / step^2
      end

      def adjust_yspeed_for_gravity
        # if there is another block directly below
        if collisions_with(Block, x, y+1).any?
          # stop accelerating downwards
          @yspeed = 0.0
        else
          # accelerate downwards
          @yspeed += gravity
        end

        while collisions_with(Block).any?
          # move upwards until not embedded in blocks
          @y -= 0.5
        end 
      end
    end
  end
end
