

# Trida predstavujici segment (usecku)
class Segment

  @l
  @r

  attr_reader :l, :r

  # Konstruktor usecky
  def initialize(l, r)
    @l = l
    @r = r
  end

  def to_s
    print "(#{@l},#{@r})"
  end

  def to_s2
    print "#{@l} #{@r}\n"
  end

end