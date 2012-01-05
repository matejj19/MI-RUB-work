require_relative './segment'

# Trida predstavujici test case
class TestCase

  # ID test casu
  @id
  
  # Konec pokryvaneho useku
  @m

  # Segmenty, ze kterych vybirame nejmensi pokryti
  @segments

  # Minimalni pocet usecek potrebnych pro pokryti useku
  @minimal_segment_count

  # Usecky, ktere tvori minimalni pokryti
  @minimal_solution

  attr_reader   :id, :m
  attr_accessor :minimal_segment_count, :minimal_solution

  # Konstruktor test case
  def initialize(id, m)
    @id = id
    @m = m
    @segments = Array.new
    @minimal_segment_count = 1
  end

  # Prida k test casu segment
  def add_segment(segment)
    @segments.push(segment)
    @minimal_segment_count += 1
  end

  # Vrati segment z dane pozice v poli segmentu
  def get_segment(position)
    @segments[position]
  end

  # Vrati pocet segmentu v test casu
  def segment_count
    @segments.length
  end

  # Vrati true, pokud je segment na dane pozici soucasti minimalniho pokryti
  def is_in_mc?(position)
    @minimal_solution[position]
  end

  # Vytiskne vysledek algoritmu minimalniho pokryti
  def print_mc
    if @minimal_segment_count == segment_count+1
      print "0\n";
    else
      print "#{@minimal_segment_count}\n"
      for i in 0..segment_count-1
        if is_in_mc?(i)
          get_segment(i).to_s2
        end
      end
    end
  end

  def to_s
    print "TestCase##{@id};length:#{@m};segments:["
    @segments.each { |segment| segment.to_s }
    print "]\n"
  end
  
end