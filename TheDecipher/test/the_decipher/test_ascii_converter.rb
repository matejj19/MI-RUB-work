require 'test/unit'
require_relative '../../lib/the_decipher/ascii_converter'

# Test tridy AsciiConverter
class TestAsciiConverter < Test::Unit::TestCase

  def test_ascii_converter
    assert_equal("*CDC is the trademark of the Control Data Corporation.\n",
      AsciiConverter.convert("1JKJ'pz'{ol'{yhklthyr'vm'{ol'Jvu{yvs'Kh{h'Jvywvyh{pvu5\n"),
      "Vracen spatny retezec")

    assert_equal("*IBM is a trademark of the International Business Machine Corporation.\n",
      AsciiConverter.convert("1PIT'pz'h'{yhklthyr'vm'{ol'Pu{lyuh{pvuhs'I|zpulzz'Thjopul'Jvywvyh{pvu5\n"),
      "Vracen spatny retezec")

    assert_equal("*DEC is the trademark of the Digital Equipment Corporation.\n",
      AsciiConverter.convert("1KLJ'pz'{ol'{yhklthyr'vm'{ol'Kpnp{hs'Lx|pwtlu{'Jvywvyh{pvu5\n"),
      "Vracen spatny retezec")
  end

end