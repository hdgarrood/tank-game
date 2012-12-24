require 'tankgame/geometry'

module TankGame
  module GameObjects
    class BaseObject
      include Geometry
      attr_reader :x, :y

      def initialize(x, y)
        @sprite = nil
        @x = x
        @y = y
      end

      def handle_events
      end

      def do_logic
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

      # true if +self+ placed at +x+, +y+ would collide with an object
      # which is an object of class +klass+
      def collided_with?(klass, x = @x, y = @y)
        $window.current_state.collided_with?(self, klass, x, y)
      end

      # does this GameObject overlap another GameObject?
      def overlap?(other)
        bounding_box.overlap?(other.bounding_box)
      end

      # a Rectangle representing the area of this object which counts as 'solid',
      # ie, is involved in collisions.
      def bounding_box
        Rectangle.new(bounding_box_top_left, bounding_box_bottom_right)
      end

      private
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
