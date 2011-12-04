class Genome < ActiveRecord::Base
  validates :name,      :presence => true
  validates :sequence,  :presence => true

  # Vrati sekvenci prolozenou znaky odradkovani
  # char_per_line -> pocet znaku na radek
  def sequence_lined(char_per_line)
    counter = char_per_line
    sequence_lined = ""
    sequence.each_char { |ch|
      sequence_lined.concat(ch)
      counter = counter - 1
      if counter == 0
        sequence_lined.concat("<br/>")
        counter = char_per_line
      end
    }

    sequence_lined
  end

  # Vytvori z nahraneho souboru novy genom
  def self.create_from_file(upload)
    sequence = upload.read.gsub(/\s+/, "")
    genome = Genome.new
    genome.name = upload.original_filename
    genome.sequence = sequence
    genome.save()
  end
end
