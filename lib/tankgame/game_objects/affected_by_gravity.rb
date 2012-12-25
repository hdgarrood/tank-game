module TankGame
  module GameObjects
    module AffectedByGravity
      # ensure that this is called after do_collision_logic, because we don't
      # want the call to collisions_with? to return any objects which +self+ is
      # actually colliding with
      def do_gravity_logic
        pretending_to_be_at(x, y+1) do
          if collisions_with(Block).any?
            @yspeed = 0
          else
            @yspeed += gravity
          end
        end
      end
    end
  end
end
