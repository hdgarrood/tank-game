require 'gosu'
require 'tankgame/geometry'
require 'tankgame/resources'
require 'tankgame/mouse'
require 'tankgame/game_objects/affected_by_gravity'
require 'tankgame/game_objects/block'
require 'tankgame/game_objects/barrel'
require 'tankgame/game_objects/collides_with_things'

module TankGame
  module GameObjects
    class Player < BaseObject
      include AffectedByGravity
      include CollidesWithThings
      include Barrel
      include Geometry

      register_collision_class(Block)

      def initialize(x, y)
        super(x, y)
        @sprite = Resources.sprites[:player]
        @xspeed = @yspeed = 0
        initialize_barrel
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
        
        handle_barrel_events
      end

      def do_logic
        do_barrel_logic

        # adjust xspeed and yspeed
        # player movement
        case @motion
        when :left
          @xspeed -= acceleration
        when :right
          @xspeed += acceleration
        end

        # friction
        @xspeed -= friction

        # move
        @x += @xspeed
        @y += @yspeed

        do_collision_logic
        do_gravity_logic
      end

      def draw
        draw_barrel
        bounding_box.draw
        super
      end

      private
      # returns the current highest possible x-acceleration for the player
      def acceleration
        0.5
      end

      # the amount the player should slow down each step.
      def friction
        @xspeed * 0.2
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
