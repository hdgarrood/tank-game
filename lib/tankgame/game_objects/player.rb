require 'gosu'
require 'tankgame/geometry'
require 'tankgame/resources'
require 'tankgame/mouse'

module TankGame
  module GameObjects
    class Player < Base
      include Geometry

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
        # motion
        case @motion
        when :left
          @xspeed -= acceleration
        when :right
          @xspeed += acceleration
        end
        @x += @xspeed
        @y += @yspeed
        if @xspeed.nonzero?
          # friction reduces the player's speed
          @xspeed > 0 ? @xspeed -= friction : @xspeed += friction
        end

        # barrel direction
        barrel_difference = @barrel_angle - @barrel_target
        if barrel_difference < barrel_rotate_speed
          @barrel_angle = @barrel_target
        elsif @barrel_angle < @barrel_target
          @barrel_angle += barrel_rotate_speed
        else
          @barrel_angle -= barrel_rotate_speed
        end
      end

      def draw
        barrel_direction = @barrel_angle.direction
        @barrel_sprite[barrel_direction].draw_rot(
          *centre,
          0,
          (@barrel_angle + Angle.new(3*PI/2)).to_gosu,
          0)
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
        Angle.new(0.1)
      end

      def width
        # FIXME: make bouncing box better for player
        32
      end

      def height
        32
      end
    end
  end
end
