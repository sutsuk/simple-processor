library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Reg is 
  port (
    Clock      : in  std_logic;
    WriteAddr  : in  std_logic_vector(3 downto 0); 
    WriteData  : in  std_logic_vector(7 downto 0); 
    WriteEnable: in  std_logic;
    ReadAddrA  : in  std_logic_vector(3 downto 0);
    ReadDataA  : out std_logic_vector(7 downto 0);
    ReadAddrB  : in  std_logic_vector(3 downto 0);
    ReadDataB  : out std_logic_vector(7 downto 0);
    ReadAddrC  : in  std_logic_vector(3 downto 0);
    ReadDataC  : out std_logic_vector(7 downto 0)
  );
end Reg;

architecture main of Reg is 
  signal Load   : std_logic_vector(15 downto 0) := X"0000"; 
  type RegDataType is array(0 to 15) of std_logic_vector(7 downto 0);
  signal RegData: RegDataType := (others => (others => '0'));
begin
  Load(0) <= '0';
  ForLoad: for a in 1 to 15 generate
    Load(a) <= '1' when WriteEnable = '1' and conv_integer(WriteAddr) = a else '0';
  end generate;
  process(Clock)
  begin
    if Clock'event and Clock = '1' then
      for a in 0 to 15 loop
        if Load(a) = '1' then
          RegData(a) <= WriteData;
        else
          RegData(a) <= RegData(a);
        end if;
      end loop;
    end if;
  end process;
  ReadDataA <= RegData(conv_integer(ReadAddrA));
  ReadDataB <= RegData(conv_integer(ReadAddrB));
  ReadDataC <= RegData(conv_integer(ReadAddrC));
end main;
