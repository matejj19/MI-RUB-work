require_relative './rectangle'

# Trida pocita obsah sjednoceni dvou ctvercu
class AreaCounter

  def self.count_area(rectangles)
    r1 = rectangles[0]
    r2 = rectangles[1]
    
    # osa x - vzdalenost obou stredu
    x_distance = (r1.x_center - r2.x_center).abs
    # osa x - presah
    x_presah = r1.pulka_hrany + r2.pulka_hrany - x_distance
    raise "Ctverce se ani dotykaji." if x_presah < 0
    
    # osa y - vzdalenost obou stredu
    y_distance = (r1.y_center - r2.y_center).abs
    # osa y - presah
    y_presah = r1.pulka_hrany + r2.pulka_hrany - y_distance
    raise "Ctverce se ani dotykaji." if y_presah < 0
    
    # obsah
    obsah_prunik = x_presah * y_presah
    r1.area + r2.area - obsah_prunik
  end

end
