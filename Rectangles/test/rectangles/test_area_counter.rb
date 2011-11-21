require 'test/unit'
require_relative '../../lib/rectangles/area_counter'
require_relative '../../lib/rectangles/rectangle'

# Test tridy AreaCounter
class TestAreaCounter < Test::Unit::TestCase

  def test_count_area
    # moje testy
    assert_equal(7, AreaCounter.count_area([Rectangle.new(2,1,1), Rectangle.new(2,2,2)]),
      "Vracen spatny obsah")

    assert_equal(8, AreaCounter.count_area([Rectangle.new(2,0,0), Rectangle.new(2,2,2)]),
      "Vracen spatny obsah")

    assert_raise(RuntimeError) {AreaCounter.count_area([Rectangle.new(2,-1,-1), Rectangle.new(2,2,2)])}

    # oficielni testy
    assert_equal(19, AreaCounter.count_area([Rectangle.new(4,0,0), Rectangle.new(2,2,2)]),
      "Vracen spatny obsah")

    assert_equal(19, AreaCounter.count_area([Rectangle.new(4.0,0.000,0.000e-3),
          Rectangle.new(2.0e+0,-2,-2e0)]),
      "Vracen spatny obsah")

    assert_raise(RuntimeError) {AreaCounter.count_area([Rectangle.new(5.23,-10e20,3e-2),
          Rectangle.new(4.345643225,+3e100,-1)])}
  end

end
