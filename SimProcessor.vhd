library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SimProcessor is
end SimProcessor;

architecture main of SimProcessor is
  signal Clock50M: std_logic := '0';
  component Processor is
    port (
      Clock50M: in  std_logic;
      SW      : in  std_logic_vector(9 downto 0);
      Key     : in  std_logic_vector(3 downto 0);
      HEX0    : out std_logic_vector(6 downto 0);
      HEX1    : out std_logic_vector(6 downto 0);
      HEX2    : out std_logic_vector(6 downto 0);
      HEX3    : out std_logic_vector(6 downto 0);
      HEX4    : out std_logic_vector(6 downto 0);
      HEX5    : out std_logic_vector(6 downto 0)
    );
  end component;
begin
  process
  begin
    wait for 10 ns;
    Clock50M <= not Clock50M;
  end process;
  MapProcessor: Processor port map (Clock50M, B"00000_00000", "0000", open, open, open, open, open, open);
end main;
