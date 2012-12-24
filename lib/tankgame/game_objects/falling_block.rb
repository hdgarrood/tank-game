module TankGame
  module GameObjects
    class FallingBlock < Block
      include AffectedByGravity
      include CollidesWithThings

      register_collision_class(Block)

      def initialize(*args)
        @xspeed = @yspeed = 0
        super(*args)
      end

      def do_logic
        @y += @yspeed
        do_collision_logic
        do_gravity_logic
      end
    end
  end
end
