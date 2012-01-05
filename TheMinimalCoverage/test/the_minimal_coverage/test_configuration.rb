require 'test/unit'
require_relative '../../lib/the_minimal_coverage/configuration'
require_relative '../../lib/the_minimal_coverage/segment'

# Test tridy Configuration
class TestTestCase < Test::Unit::TestCase

  def test_general
    min_solution = Array.new(2)
    for i in 0..min_solution.length-1
      min_solution[i] = false
    end
    line = Array.new(1)
    for j in 0..line.length-1
      line[j] = false
    end
    c = Configuration.new(1, 0, min_solution, line)

    assert_equal(0, c.min_count, "Min_count ma byt roven 0")

    assert_equal(false, c.is_covered?, "Usek nema byt pokryty")

    c.add_segment(0, Segment.new(0, 1))

    assert_equal(1, c.min_count, "Min_count ma byt roven 1")

    assert_equal(true, c.is_covered?, "Usek ma byt pokryty")

  end

end