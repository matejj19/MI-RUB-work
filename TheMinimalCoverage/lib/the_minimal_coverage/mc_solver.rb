require_relative './test_case'
require_relative './segment'
require_relative './configuration'

# Trida resi problem minimalniho pokryti brutalni silou
class MCSolver

  # Nalezne minimalni pokryti
  def self.find_mc(test_case)

    # inicializujeme zasobnik
    stack = Array.new

    # vyrobime pocatecni konfiguraci a vlozime ji na zasobnik
    min_solution = Array.new(test_case.segment_count)
    for i in 0..min_solution.length-1
      min_solution[i] = false
    end
    line = Array.new(test_case.m)
    for j in 0..line.length-1
      line[j] = false
    end
    start_conf = Configuration.new(0, 0, min_solution, line)
    stack.push(start_conf)

    while !stack.empty?
      # odebirame posledne pridany prvek
      current = stack.pop

      # pokud je usek pokryt, dale nevetvime a zjistujeme,
      # zda jsme nenasli nove nejmensi pokryti
      if current.is_covered?
        if current.min_count < test_case.minimal_segment_count
            test_case.minimal_segment_count = current.min_count
            test_case.minimal_solution = current.min_solution
        end

      # pokud usek neni pokryt, expandujeme dalsi stavy
      else
        for i in current.h..test_case.segment_count-1
          new_conf = Configuration.new(i+1, current.min_count,
            current.min_solution, current.line)
          new_conf.add_segment(i, test_case.get_segment(i))
          stack.push(new_conf)
        end
      end
      
    end
  end

end
