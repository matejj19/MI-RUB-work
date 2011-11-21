

# Konvertuje zadany string
class AsciiConverter

  def self.convert(line)
    newline = []
    i = 0
    line.bytes { |num|
      newchar = (num - 7).chr
      newline.insert(i, newchar)
      i = i + 1
    }
    newline[i-1] = "\n"
    newline.join("")
  end

end