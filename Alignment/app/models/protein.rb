class Protein < ActiveRecord::Base

  # Vytvori z nahraneho souboru databazi proteinu
  # Parseruje vstup a generuje jednotlive Proteiny
  def self.generate_db(upload)
    input = StringScanner.new(upload.read)

    while !input.eos?
      protein = Protein.new

      input.scan_until(/\|/)
      protein.id = input.scan(/\d+/)
      input.scan_until(/]/)
      protein.sequence = input.scan_until(/>|\z/).gsub(/\s+|>/, "")
      
      protein.save();
    end
  end

end
