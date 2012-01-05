require_relative './rectangle'

# Trida starajici se o nacteni vstupu
class InputReader

    # Nacte vstup
    def self.read_input
      first = read_rec("prvniho")
      second = read_rec("druheho")

      [first, second]
    end

  private
    # Nacte jeden ctverec
    def self.read_rec(poradi)
      rec = Rectangle.new

      begin
        print("Zadejte delku hrany #{poradi} cverce: ")
        rec.delka_hrany = Float(gets.chop)
        raise if rec.delka_hrany < 0.0
    
        print("Zadejte x-ovou souradnici stredu #{poradi} cverce: ")
        rec.x_center = Float(gets.chop)

        print("Zadejte y-ovou souradnici stredu #{poradi} cverce: ")
        rec.y_center = Float(gets.chop)

      rescue
        print("Spatny vstup.\n")
        exit
      end

      rec
    end

end