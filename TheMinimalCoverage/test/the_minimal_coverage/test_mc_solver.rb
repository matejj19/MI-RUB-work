require 'test/unit'
require_relative '../../lib/the_minimal_coverage/mc_solver'
require_relative '../../lib/the_minimal_coverage/test_case'
require_relative '../../lib/the_minimal_coverage/segment'
require_relative '../../lib/the_minimal_coverage/configuration'

# Test tridy MCSolver
class TestTestCase < Test::Unit::TestCase

  def test_general
    tc = TestCase.new(1, 6)
    s = Segment.new(0, 2)
    tc.add_segment(s)
    s = Segment.new(2, 4)
    tc.add_segment(s)
    s = Segment.new(4, 6)
    tc.add_segment(s)
    s = Segment.new(6, 8)
    tc.add_segment(s)

    MCSolver.find_mc(tc)

    assert_equal(true, tc.is_in_mc?(0), "Usecka ma byt ve vysledu")

    assert_equal(true, tc.is_in_mc?(1), "Usecka ma byt ve vysledu")

    assert_equal(true, tc.is_in_mc?(2), "Usecka ma byt ve vysledu")

    assert_equal(false, tc.is_in_mc?(3), "Usecka nema byt ve vysledu")

  end

end