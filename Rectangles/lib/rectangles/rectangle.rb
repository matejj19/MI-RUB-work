

# Trida predstavujici obdelnik (zde primo ctverec)
class Rectangle

  @delka_hrany
  @x_center
  @y_center

  attr_accessor :delka_hrany, :x_center, :y_center

  # Konstruktor lze pouzit i jako prazdny
  def initialize(delka_hrany=nil, x_center=nil, y_center=nil)
    @delka_hrany = delka_hrany
    @x_center = x_center
    @y_center = y_center
  end

  def area
    delka_hrany * delka_hrany
  end

  def pulka_hrany
    delka_hrany/2
  end
end
