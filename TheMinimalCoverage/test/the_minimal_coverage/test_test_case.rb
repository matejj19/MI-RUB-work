require 'test/unit'
require_relative '../../lib/the_minimal_coverage/test_case'
require_relative '../../lib/the_minimal_coverage/segment'

# Test tridy TestCase
class TestTestCase < Test::Unit::TestCase

  @@tc = TestCase.new(1, 3)

  def test_is_in_mc?
    @@tc.minimal_solution = [true, false, true]

    assert_equal(false, @@tc.is_in_mc?(1), "Segment nema byt v reseni")

    assert_equal(true, @@tc.is_in_mc?(0), "Segment ma byt v reseni")

  end

  def test_equal
    @@tc.add_segment(Segment.new(1, 4))

    assert_equal(1, @@tc.segment_count, "Vracen spatny pocet segmentu")
    
  end

end