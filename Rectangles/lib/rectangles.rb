require_relative './rectangles/input_reader'
require_relative './rectangles/area_counter'
require_relative './rectangles/rectangle'

# Commandline interface
rectangles = InputReader.read_input
begin
  area = AreaCounter.count_area(rectangles)
rescue => e
  print(e.message)
  print("\n")
  exit
end

print("Obsah sjednoceni dvou ctvercu je #{area}.\n")