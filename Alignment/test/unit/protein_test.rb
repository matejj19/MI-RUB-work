require_relative '../test_helper'

class ProteinTest < ActiveSupport::TestCase
 
  def test_generate_db
    proteins = ">gi|317462460|gb|ADV24198.1| Hypothetical Protein CGB_I0130W
[Cryptococcus gattii WM276]
MPATRQKEEGDQTPNGTQKRPRNANKQWATDIDDNGVSAERHVAIWLASTSQNERLTNYHRWTIGHEKKD
YLADQCHQYLIEKGCDSRRQVKGVFLKINHIVDTFNRASMLGSGINGNAEEAEGSNLASQRNNICPLYEI
LAPVLVNRPPTAEHSSSPSLHRSLDPPNPERAASRARVQRQNESLEDEPFNDDDDADEDDRGAMNVDIRD
NGPRGQDGHFSDDADLEMDDVTAVNDRGNELARQKERNDERRHIEKLVMLRRHHVNLMKYKREKLGFAHR
KMDLQERNTRAKERKVELMDYKAKTKELIVKLEERNTKAKERIAESQERRVKAKERILEIQIYQAKMRRW
YNQMDLFIKSGKNWEEASALTGPEPDSIFNI
>gi|317462509|gb|ADV24247.1| Hypothetical Protein CGB_I0140C
[Cryptococcus gattii WM276]
MSSARSILGLRPQLSHSRALPLKTLLCQTDADQIPCGPRQPYTPIDNNNKRRCKDAKTQEGPPWGSWPAQ
PPPRRPLHDNQPNIIKQANKLIENGRLESTERVLEEDASVAELTPEILQQLNAKHPRKPRNPFGHAVGLT
PGQAPEVNVILKVLDASSPTQRLVSAVGRYRSSS"

    a = Protein.generate_db(proteins)
  end
end
