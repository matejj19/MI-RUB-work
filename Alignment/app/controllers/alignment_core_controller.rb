class AlignmentCoreController < ApplicationController
  # Hodnota gap penalty je staticky nastavena na -1
  @@d = -3

  # tabulka BLOSUM62
  @@blosum62 = {'AA'=>4,'AR'=>-1,'AN'=>-2,'AD'=>-2,'AC'=>0,'AQ'=>-1,'AE'=>-1,
    'AG'=>0,'AH'=>-2,'AI'=>-1,'AL'=>-1,'AK'=>-1,'AM'=>-1,'AF'=>-2,'AP'=>-1,
    'AS'=>1,'AT'=>0,'AW'=>-3,'AY'=>-2,'AV'=>0,'AB'=>-2,'AZ'=>-1,'AX'=>0,
    'RR'=>5,'NR'=>0,'DR'=>-2,'CR'=>-3,'QR'=>1,'ER'=>0,'GR'=>-2,'HR'=>0,
    'IR'=>-3,'LR'=>-2,'KR'=>2,'MR'=>-1,'FR'=>-3,'PR'=>-2,'RS'=>-1,'RT'=>-1,
    'RW'=>-3,'RY'=>-2,'RV'=>-3,'BR'=>-1,'RZ'=>0,'RX'=>-1,'NN'=>6,'DN'=>1,
    'CN'=>-3,'NQ'=>0,'EN'=>0,'GN'=>0,'HN'=>1,'IN'=>-3,'LN'=>-3,'KN'=>0,
    'MN'=>-2,'FN'=>-3,'NP'=>-2,'NS'=>1,'NT'=>0,'NW'=>-4,'NY'=>-2,'NV'=>-3,
    'BN'=>3,'NZ'=>0,'NX'=>-1,'DD'=>6,'CD'=>-3,'DQ'=>0,'DE'=>2,'DG'=>-1,
    'DH'=>-1,'DI'=>-3,'DL'=>-4,'DK'=>-1,'DM'=>-3,'DF'=>-3,'DP'=>-1,
    'DS'=>0,'DT'=>-1,'DW'=>-4,'DY'=>-3,'DV'=>-3,'BD'=>4,'DZ'=>1,'DX'=>-1,
    'CC'=>9,'CQ'=>-3,'CE'=>-4,'CG'=>-3,'CH'=>-3,'CI'=>-1,'CL'=>-1,'CK'=>-3,
    'CM'=>-1,'CF'=>-2,'CP'=>-3,'CS'=>-1,'CT'=>-1,'CW'=>-2,'CY'=>-2,
    'CV'=>-1,'BC'=>-3,'CZ'=>-3,'CX'=>-2,'QQ'=>5,'EQ'=>2,'GQ'=>-2,'HQ'=>0,
    'IQ'=>-3,'LQ'=>-2,'KQ'=>1,'MQ'=>0,'FQ'=>-3,'PQ'=>-1,'QS'=>0,'QT'=>-1,
    'QW'=>-2,'QY'=>-1,'QV'=>-2,'BQ'=>0,'QZ'=>3,'QX'=>-1,'EE'=>5,'EG'=>-2,
    'EH'=>0,'EI'=>-3,'EL'=>-3,'EK'=>1,'EM'=>-2,'EF'=>-3,'EP'=>-1,'ES'=>0,
    'ET'=>-1,'EW'=>-3,'EY'=>-2,'EV'=>-2,'BE'=>1,'EZ'=>4,'EX'=>-1,'GG'=>6,
    'GH'=>-2,'GI'=>-4,'GL'=>-4,'GK'=>-2,'GM'=>-3,'FG'=>-3,'GP'=>-2,'GS'=>0,
    'GT'=>-2,'GW'=>-2,'GY'=>-3,'GV'=>-3,'BG'=>-1,'GZ'=>-2,'GX'=>-1,'HH'=>8,
    'HI'=>-3,'HL'=>-3,'HK'=>-1,'HM'=>-2,'FH'=>-1,'HP'=>-2,'HS'=>-1,'HT'=>-2,
    'HW'=>-2,'HY'=>2,'HV'=>-3,'BH'=>0,'HZ'=>0,'HX'=>-1,'II'=>4,'IL'=>2,
    'IK'=>-3,'IM'=>1,'FI'=>0,'IP'=>-3,'IS'=>-2,'IT'=>-1,'IW'=>-3,'IY'=>-1,
    'IV'=>3,'BI'=>-3,'IZ'=>-3,'IX'=>-1,'LL'=>4,'KL'=>-2,'LM'=>2,'FL'=>0,
    'LP'=>-3,'LS'=>-2,'LT'=>-1,'LW'=>-2,'LY'=>-1,'LV'=>1,'BL'=>-4,'LZ'=>-3,
    'LX'=>-1,'KK'=>5,'KM'=>-1,'FK'=>-3,'KP'=>-1,'KS'=>0,'KT'=>-1,'KW'=>-3,
    'KY'=>-2,'KV'=>-2,'BK'=>0,'KZ'=>1,'KX'=>-1,'MM'=>5,'FM'=>0,'MP'=>-2,
    'MS'=>-1,'MT'=>-1,'MW'=>-1,'MY'=>-1,'MV'=>1,'BM'=>-3,'MZ'=>-1,'MX'=>-1,
    'FF'=>6,'FP'=>-4,'FS'=>-2,'FT'=>-2,'FW'=>1,'FY'=>3,'FV'=>-1,'BF'=>-3,
    'FZ'=>-3,'FX'=>-1,'PP'=>7,'PS'=>-1,'PT'=>-1,'PW'=>-4,'PY'=>-3,'PV'=>-2,
    'BP'=>-2,'PZ'=>-1,'PX'=>-2,'SS'=>4,'ST'=>1,'SW'=>-3,'SY'=>-2,'SV'=>-2,
    'BS'=>0,'SZ'=>0,'SX'=>0,'TT'=>5,'TW'=>-2,'TY'=>-2,'TV'=>0,'BT'=>-1,
    'TZ'=>-1,'TX'=>0,'WW'=>11,'WY'=>2,'VW'=>-3,'BW'=>-4,'WZ'=>-3,'WX'=>-2,
    'YY'=>7,'VY'=>-1,'BY'=>-3,'YZ'=>-2,'XY'=>-1,'VV'=>4,'BV'=>-3,'VZ'=>-2,
    'VX'=>-1,'BB'=>4,'BZ'=>1,'BX'=>-1,'ZZ'=>4,'XZ'=>-1,'XX'=>-1
  }

  # Metoda ridici zarovnani vybrane sekvence se sekvencemi
  # ulozenymi v genove DB
  def align
    @genome = Genome.find(params[:id])
    @proteins = Protein.all
    @method = params[:method]

    if params[:method] == 'local'
      @message = 'Local alignment'
      align_all_local
    elsif params[:method] == 'global'
      @message = 'Global alignment'
      align_all_global
    end

  end

  # Vizualizace vybraneho zarovnani
  def show_align
    @genome = Genome.find(params[:gid])
    @protein = Protein.find(params[:pid])

    if params[:method] == 'local'
      align_local(@protein)
      @vis = visualize_local
    elsif params[:method] == 'global'
      align_global(@protein)
      @vis = visualize_global
    end
  end

  # Vyvola postupne nad vsemi proteiny v genove DB
  # algoritmus globalniho zarovnani
  def align_all_global
    @results = []
    @proteins.each { |protein|
      @results << align_global(protein)
    }
    @results = @results.sort_by { |evaluated_protein| evaluated_protein.value }
  end

  # Globalne zarovna zadany protein s uzivatelem vybranym genomem
  def align_global(protein)
    # Vytvoreni tabulky
    x = protein.sequence.size
    y = @genome.sequence.size
    tab = Array.new(x+1) { Array.new(y+1) }

    # Vyplnime prvni radek a sloupec
    for i in 0..x
      tab[i][0] = @@d * i
    end
    for j in 0..y
      tab[0][j] = @@d * j
    end

    for i in 1..x
      for j in 1..y
        match = tab[i-1][j-1] + match(i, j, protein)
        delete = tab[i-1][j] + @@d
        insert = tab[i][j-1] + @@d

        tab[i][j] = [match, delete, insert].max
      end
    end

    @table = tab
    value = tab[x][y]
    EvaluatedProtein.new(protein, value)
  end

  # Spocita a vrati hodnotu shody/neshody dvou pismen
  def match(i, j, protein)
    twin = [protein.sequence[i-1], @genome.sequence[j-1]].sort
    st = twin.join
    @@blosum62[st]
  end

  # Vyvola postupne nad vsemi proteiny v genove DB
  # algoritmus lokalniho zarovnani
  def align_all_local
    @results = []
    @proteins.each { |protein|
      @results << align_local(protein)
    }
    @results = @results.sort_by { |evaluated_protein| evaluated_protein.value }
  end

  # Lokalne zarovna zadany protein s uzivatelem vybranym genomem
  def align_local(protein)
    # Vytvoreni tabulky
    x = protein.sequence.size
    y = @genome.sequence.size
    tab = Array.new(x+1) { Array.new(y+1) }

    # Vyplnime prvni radek a sloupec
    for i in 0..x
      tab[i][0] = 0
    end
    for j in 0..y
      tab[0][j] = 0
    end

    for i in 1..x
      for j in 1..y
        match = tab[i-1][j-1] + match(i, j, protein)
        delete = tab[i-1][j] + @@d
        insert = tab[i][j-1] + @@d

        tab[i][j] = [match, delete, insert, 0].max
      end
    end

    @table = tab
    value = 0
    @lok_max_coordinates = [0,0]
    for i in 1..x
      for j in 1..y
        if tab[i][j] >= value
          value = tab[i][j]
          @lok_max_coordinates = [i, j]
        end
      end
    end
    EvaluatedProtein.new(protein, value)
  end

  # Vizualizuje vybrane globalni zarovnani
  def visualize_global
    protein_str = ""
    genome_str = ""

    x = @protein.sequence.size
    y = @genome.sequence.size

    while x > 0 and y > 0
      score = @table[x][y]
      score_diag = @table[x-1][y-1]
      #score_up = @table[x][y-1]
      score_left = @table[x-1][y]

      if score == (score_diag + match(x, y, @protein))
        protein_str = @protein.sequence[x-1].concat(protein_str)
        genome_str = @genome.sequence[y-1].concat(genome_str)
        x -= 1
        y -= 1
      elsif score == (score_left + @@d)
        protein_str = @protein.sequence[x-1].concat(protein_str)
        genome_str = "-".concat(genome_str)
        x -= 1
      else
        protein_str = "-".concat(protein_str)
        genome_str = @genome.sequence[y-1].concat(genome_str)
        y -= 1
      end
    end

    while x > 0
      protein_str = @protein.sequence[x-1].concat(protein_str)
      genome_str = "-".concat(genome_str)
      x -= 1
    end

    while y > 0
      protein_str = "-".concat(protein_str)
      genome_str = @genome.sequence[y-1].concat(genome_str)
      y -= 1
    end

    [protein_str, genome_str]
  end

  # Vizualizuje vybrane lokalni zarovnani
  def visualize_local
    protein_str = ""
    genome_str = ""

    x = @lok_max_coordinates[0]
    y = @lok_max_coordinates[1]

    while x > 0 and y > 0 and @table[x][y] > 0
      score = @table[x][y]
      score_diag = @table[x-1][y-1]
      #score_up = @table[x][y-1]
      score_left = @table[x-1][y]

      if score == (score_diag + match(x, y, @protein))
        protein_str = @protein.sequence[x-1].concat(protein_str)
        genome_str = @genome.sequence[y-1].concat(genome_str)
        x -= 1
        y -= 1
      elsif score == (score_left + @@d)
        protein_str = @protein.sequence[x-1].concat(protein_str)
        genome_str = "-".concat(genome_str)
        x -= 1
      else
        protein_str = "-".concat(protein_str)
        genome_str = @genome.sequence[y-1].concat(genome_str)
        y -= 1
      end
    end

    [protein_str, genome_str]
  end

end
