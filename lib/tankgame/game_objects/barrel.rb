require 'tankgame/geometry/angle'

module TankGame
  module GameObjects
    # to be included in Player
    module Barrel
      include Geometry

      def initialize_barrel
        @barrel_angle = Angle.new(0)
        @barrel_sprite = {
          :left => Resources.sprites[:barrel_left],
          :right => Resources.sprites[:barrel_right]
        }
      end

      def barrel_rotate_speed
        0.1
      end

      def handle_barrel_events
        # work out which direction the barrel wants to be pointing
        mouse_angle = Angle.bearing(centre, Mouse)
        case mouse_angle.quadrant
        when :first
          @barrel_target = Angle.new(0)
        when :second
          @barrel_target = Angle.new(Math::PI)
        else
          @barrel_target = mouse_angle
        end
      end

      def do_barrel_logic
        @barrel_angle = new_barrel_angle(@barrel_angle, @barrel_target)
      end

      def draw_barrel
        @barrel_sprite[@barrel_angle.direction].draw_rot(
          *centre, 0, @barrel_angle.to_gosu, 0)
      end

      # returns the new angle which the barrel should be pointing, given its
      # current angle and its target
      def new_barrel_angle(current, target)
        hard_left = Angle.new(Math::PI)
        hard_right = Angle.new(0)

        if (current.to_f - target.to_f).abs <= barrel_rotate_speed
          target
        elsif target == hard_left || current == hard_right
          current - barrel_rotate_speed
        elsif target == hard_right || current == hard_left
          current + barrel_rotate_speed
        elsif current < target
          current + barrel_rotate_speed
        else
          current - barrel_rotate_speed
        end
      end
    end
  end
end
