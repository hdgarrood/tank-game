require 'tankgame/geometry'

module TankGame
  module GameObjects
    class BaseObject
      include Geometry
      attr_accessor :x, :y

      def initialize(x, y)
        @sprite = nil
        @x = x
        @y = y
      end

      def handle_events
      end

      def do_logic
      end

      def gravity
        0.5 # pixels / step^2
      end

      def draw
        @sprite.draw(@x, @y, 0)
      end

      # the object's physical width, used for collisions
      def width
        0
      end

      # the object's physical height, used for collisions
      def height
        0
      end

      # the distance (x) from @x to the top-left corner of the object's
      # bouncing box in pixels
      def offset_x
        0
      end

      # the distance (y) from @y to the top-left corner of the object's
      # bouncing box in pixels
      def offset_y
        0
      end

      # returns an Array of all the objects of class +klass+ which collide with
      # self, when placed at +x+, +y+
      def collisions_with(klass)
        $window.current_state.collisions_with(self, klass)
      end

      # does this GameObject overlap the passed instance of GameObject?
      def overlap?(other)
        bounding_box.overlap?(other.bounding_box)
      end

      # a Rectangle representing the area of this object which counts as
      # 'solid', ie, is involved in collisions.
      def bounding_box
        Rectangle.new(bounding_box_top_left, bounding_box_bottom_right)
      end

      def pretending_to_be_at(pretend_x, pretend_y)
        old_x, old_y = @x, @y
        @x, @y = pretend_x, pretend_y
        yield
        @x, @y = old_x, old_y
      end

      private
      # adds a new GameObject to the current game state.
      def add_game_object(obj)
        $window.current_state.add_game_object(obj)
      end

      # returns a Point of what looks like the centre of the object (judging by
      # the sprite)
      def centre
        Point.new(@x + (@sprite.width / 2), @y + (@sprite.height / 2))
      end

      # used in #bounding_box; returns a Point of the top left of this object's
      # bounding box
      def bounding_box_top_left
        Point.new(@x + offset_x, @y + offset_y)
      end

      def bounding_box_bottom_right
        Point.new(@x + offset_x + width, @y + offset_y + height)
      end
    end
  end
end
