require 'tankgame/geometry'
require 'test/unit'

class AngleTest < Test::Unit::TestCase
  include TankGame::Geometry
  include Math

  def test_angles_are_always_between_0_and_2pi
    a1 = Angle.new(-1)
    assert a1.to_f.between?(0, 2*PI)

    a2 = Angle.new(7)
    assert a2.to_f.between?(0, 2*PI)
  end

  def test_to_f_returns_a_float
    a = Angle.new(0)
    assert_equal a.to_f.class, Float
  end

  def test_angles_are_in_the_correct_quadrant
    { :first => 0.1,
      :second => PI/2 + 0.1,
      :third => PI + 0.1,
      :fourth => 3*PI/2 + 0.1 }.each do |quad, radians|
      assert_equal Angle.new(radians).quadrant, quad,
        "an angle of #{radians} radians should be in the #{quad} quadrant."
    end
  end
end
