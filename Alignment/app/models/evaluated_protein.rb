
# Trida obaluje tridu protein
# Predstavuje protein s hodnotou shody
class EvaluatedProtein
  @protein
  @value

  def initialize(protein, value)
    @protein = protein
    @value = value
  end

  attr_reader :protein, :value

end
