require_relative './segment'

# Predstavuje konfiguraci na zasobniku
class Configuration

  # Aktualni hloubka stavoveho prostoru
  @h

  # Pocet usecek potrebnych k minimalnimu pokryti
  @min_count

  # Usecky, ktere tvori minimalni pokryti
  @min_solution

  # Reprezentuje pokryvany usek, postupne ho "zakryvame"
  @line

  attr_reader :h, :min_count, :min_solution, :line

  # Konstruktor konfigurace
  def initialize(h, min_count, min_solution, line)
    @h = h
    @min_count = min_count
    @min_solution = min_solution.clone
    @line = line.clone
  end

  # Prida usecku do minimalniho pokryti
  def add_segment(position, segment)
    @min_count += 1
    @min_solution[position] = true
    cover_line(segment)
  end

  # Vrati true, pokud je usek pokryt cely
  def is_covered?
    for i in 0..@line.length
      return false if @line[i] == false
    end

    return true
  end

  private
    # Zakryje odpovidajici cast useku useckou
    def cover_line(segment)
      l = segment.l
      r = segment.r
      l = 0 if l < 0
      r -= 1
      r = @line.length-1 if r > @line.length-1

      for i in l..r
        @line[i] = true
      end
    end

end
