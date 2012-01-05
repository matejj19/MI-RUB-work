require_relative './test_case'
require_relative './segment'

# Trida starajici se o nacteni vstupu
class InputReader

  # Nacte test cases
  def self.read_input()
    # nacteme pocet test cases
    test_cases = Array.new(STDIN.gets.to_i)
    
    id = 0
    for test_case in test_cases
      # prazdny radek
      STDIN.gets
      # nacteme delku usecky
      m = STDIN.gets.to_i
      # vytvorime test case
      test_case = TestCase.new(id+1, m)
      # nacteme segmenty test casu
      read_segments(test_case)
      test_cases[id] = test_case
      id += 1
    end

    test_cases
  end

  private
    # Nacte segmenty jednoho test casu
    def self.read_segments(test_case)
      tokens = STDIN.gets.scan(/[+-]?\d+/)
      while !(tokens[0].to_i == 0 && tokens[1].to_i == 0)
        test_case.add_segment(Segment.new(tokens[0].to_i, tokens[1].to_i))
        tokens = STDIN.gets.scan(/[+-]?\d+/)
      end
    end

end