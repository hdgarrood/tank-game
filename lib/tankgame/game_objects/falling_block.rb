module TankGame
  module GameObjects
    class FallingBlock < Block
      include AffectedByGravity
      def initialize(*args)
        @y = @yspeed = 0
        super(*args)
      end

      def do_logic
        if @y > 300
          require 'debugger'; debugger
        end
        adjust_yspeed_for_gravity
        @y += @yspeed
      end
    end
  end
end
