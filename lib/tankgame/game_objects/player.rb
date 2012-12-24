require 'gosu'
require 'tankgame/geometry'
require 'tankgame/resources'
require 'tankgame/mouse'
require 'tankgame/game_objects/affected_by_gravity'
require 'tankgame/game_objects/block'
require 'tankgame/game_objects/collides_with_things'

module TankGame
  module GameObjects
    class Player < BaseObject
      include AffectedByGravity
      include CollidesWithThings
      include Geometry

      register_collision_class(Block)

      def initialize(x, y)
        super(x, y)
        @sprite = Resources.sprites[:player]
        @barrel_sprite = {
          :left => Resources.sprites[:barrel_left],
          :right => Resources.sprites[:barrel_right]
        }
        @xspeed = @yspeed = 0
        @barrel_angle = Angle.new(0)
      end

      def handle_events
        # left/right motion
        if $window.button_down? Gosu::KbD
          @motion = :right
        elsif $window.button_down? Gosu::KbA
          @motion = :left
        else
          @motion = :none
        end
        
        # work out which direction the barrel wants to be pointing
        mouse_angle = Angle.bearing(self, Mouse)
        case mouse_angle.quadrant
        when :first
          @barrel_target = Angle.new(0)
        when :second
          @barrel_target = Angle.new(Math::PI)
        else
          @barrel_target = mouse_angle
        end
      end

      def do_logic
        # adjust xspeed and yspeed
        # player movement
        case @motion
        when :left
          @xspeed -= acceleration
        when :right
          @xspeed += acceleration
        end

        # friction
        if @xspeed.nonzero?
          # friction reduces the player's speed
          @xspeed > 0 ? @xspeed -= friction : @xspeed += friction
        end

        # move
        @x += @xspeed
        @y += @yspeed

        do_collision_logic
        do_gravity_logic

        # barrel direction
        @barrel_angle = @barrel_target
      end

      def draw
        barrel_direction = @barrel_angle.direction
        @barrel_sprite[barrel_direction].draw_rot(
          *centre,
          0,
          @barrel_angle.to_gosu,
          0)
        bounding_box.draw
        super
      end

      private
      # returns the current highest possible x-acceleration for the player
      def acceleration
        0.5
      end

      # the amount the player should slow down each step if he stops
      # pressing buttons. returns absolute value
      def friction
        (@xspeed * 0.2).abs
      end

      def barrel_rotate_speed
        0.1
      end

      # either :clockwise or :anticlockwise
      def barrel_rotation_direction
      end

      def width
        32
      end

      def height
        32
      end
    end
  end
end
