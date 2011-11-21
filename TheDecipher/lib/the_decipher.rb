require_relative './the_decipher/ascii_converter'

# Commandline interface
f = File.open("../vstup", "r") {|f|
  while !f.eof?
    line = f.gets
    print(AsciiConverter.convert(line))
  end
}