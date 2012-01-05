require_relative './the_minimal_coverage/input_reader'
require_relative './the_minimal_coverage/test_case'
require_relative './the_minimal_coverage/mc_solver'

# Commandline interface

# Nacteni vstupnich dat
test_cases = InputReader.read_input

# Kontrolni vypis nactenych dat
for test_case in test_cases
  test_case.to_s
end

# Reseni problemu minimalniho pokryti
for tc in test_cases
  MCSolver.find_mc(tc)
  tc.print_mc
  print "\n"
end