library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity InstractionMemory is
  port (
    Addr: in  std_logic_vector(7 downto 0);
    Data: out std_logic_vector(23 downto 0)
  );
end InstractionMemory;

architecture main of InstractionMemory is
  type InstractionMemoryType is array(0 to 255) of std_logic_vector(23 downto 0);
  constant Memory: InstractionMemoryType := (
    0 => B"1_0_0001_0000_0000_0001_011111",
    1 => B"0_0_0000_0000_0000_0000_000000",
    2 => B"0_0_0000_0000_0000_0000_000000",
    others => B"0_0_0000_0000_0000_0000_000000"
  );
begin
  Data <= Memory(conv_integer(Addr));
end main;
