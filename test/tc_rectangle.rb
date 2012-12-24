require 'tankgame/geometry'
require 'test/unit'

class RectangleTest < Test::Unit::TestCase
  include TankGame::Geometry

  def test_rectangles_overlapping
    p1 = Point.new(0, 0)
    p2 = Point.new(2, 2)
    rect1 = Rectangle.new(p1, p2)

    p3 = Point.new(1, 1)
    p4 = Point.new(3, 3)
    rect2 = Rectangle.new(p3, p4)

    assert rect1.overlap?(rect2)

    rect3 = Rectangle.new(p1, p3)
    rect4 = Rectangle.new(p2, p4)

    assert !rect3.overlap?(rect4)

    rect5 = Rectangle.new(p3, p4)

    assert !rect5.overlap?(rect3)

    assert rect1.overlap?(rect1),
      "rectangles should overlap themselves"
  end
end
