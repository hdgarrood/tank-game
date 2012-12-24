module TankGame
  module Geometry
    class Rectangle
      # takes two objects which respond to :to_point, representing the two
      # corners of a rectangle
      def initialize(p1, p2)
        # get x and y values
        x1, y1 = p1.to_point.to_a
        x2, y2 = p2.to_point.to_a

        # swap if need be, so that x1 <= x2 and y1 <= y2
        x1, x2 = x2, x1 if x1 > x2
        y1, y2 = y2, y1 if y1 > y2

        @x1, @x2, @y1, @y2 = x1, x2, y1, y2
      end

      # is the passed Point inside self?
      def contains_point?(p, opts = {:inclusive => true})
        gt_op, lt_op = opts[:inclusive] ? [:>, :<] : [:>=, :<=]
        p.x.send(gt_op, @x1) &&
          p.x.send(lt_op, @x2) &&
          p.y.send(gt_op, @y1) &&
          p.y.send(lt_op, @y2)
      end

      # returns top-left and bottom-right corner
      def two_corners
        [Point.new(@x1, @y1), Point.new(@x2, @y2)]
      end

      def four_corners
        [
          Point.new(@x1, @y1),
          Point.new(@x2, @y1),
          Point.new(@x1, @y2),
          Point.new(@x2, @y2)
        ]
      end

      # does this Rectangle overlap with another Rectangle?
      # this can be optimised
      def overlap?(other)
        four_corners.any? { |c| c.within_rectangle?(other) }
      end
    end
  end
end
