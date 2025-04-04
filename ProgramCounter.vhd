library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ProgramCounter is
  port (
    Clock   : in  std_logic;
    JumpFlag: in  std_logic;
    JumpAddr: in  std_logic_vector(7 downto 0);
    Addr    : out std_logic_vector(7 downto 0)
  );
end ProgramCounter;

architecture main of ProgramCounter is
  signal AddrNext: std_logic_vector(7 downto 0) := "00000000";
  signal AddrNode: std_logic_vector(7 downto 0) := "00000000";
begin
  AddrNext <= AddrNode + '1' when JumpFlag = '0' else AddrNode + '1' + JumpAddr;
  process(Clock)
  begin
    if Clock'event and Clock = '1' then
      AddrNode <= AddrNext;
    end if;
  end process;
  Addr <= AddrNode;
end main;
