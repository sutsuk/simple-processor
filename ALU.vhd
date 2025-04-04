library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is
  port (
    Ctrl   : in  std_logic_vector(3 downto 0);
    DataInA: in  std_logic_vector(7 downto 0);
    DataInB: in  std_logic_vector(7 downto 0);
    DataInC: in  std_logic_vector(7 downto 0);
    ALUO   : out std_logic_vector(7 downto 0);
    ZF     : out std_logic
  );
end ALU;

architecture main of ALU is
  signal ResultAND: std_logic_vector(7 downto 0) := "00000000";
  signal ResultOR : std_logic_vector(7 downto 0) := "00000000";
  signal ResultADD: std_logic_vector(7 downto 0) := "00000000";
  signal ResultSUB: std_logic_vector(7 downto 0) := "00000000";
  signal ResultSLT: std_logic_vector(7 downto 0) := "00000000";
  signal ResultNOR: std_logic_vector(7 downto 0) := "00000000";
  signal ALUONode : std_logic_vector(7 downto 0) := "00000000";
begin
  ResultAND <= DataInA and DataInB;
  ResultOR <= DataInA or DataInB;
  ResultADD <= DataInA + DataInB;
  ResultSUB <= DataInA - DataInB;
  ResultSLT <= "0000000" & ResultSUB(7);
  ResultNOR <= DataInA nor DataInB;
  ALUONode <= ResultAND when Ctrl = "0000" else
              ResultOR when Ctrl = "0001" else
              ResultADD when Ctrl = "0010" else 
              ResultSUB when Ctrl = "0110" else
              ResultSLT when Ctrl = "0111" else
              ResultNOR when Ctrl = "1100" else 
              DataInC when Ctrl = "1111" else "11111111";
  ALUO <= ALUONode;
  process(ALUONode)
    variable ZFNode: std_logic := '0';
  begin
    for a in 0 to 7 loop
      ZFNode := ZFNode or ALUONode(a);
    end loop;
    ZF <= not ZFNode;
  end process;
end main;

