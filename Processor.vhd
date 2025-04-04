library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Processor is
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
end Processor;

architecture main of Processor is
  signal Clock          : std_logic := '0';
  signal JumpFlag       : std_logic := '0';
  signal JumpAddr       : std_logic_vector(7 downto 0) := "00000000";
  signal InstractionAddr: std_logic_vector(7 downto 0) := "00000000";
  signal InstractionData: std_logic_vector(23 downto 0) := X"000000";
  signal ALUCtrl        : std_logic_vector(3 downto 0) := "0000";
  signal ALUDataInA     : std_logic_vector(7 downto 0) := "00000000";
  signal ALUDataInB     : std_logic_vector(7 downto 0) := "00000000";
  signal ALUDataInC     : std_logic_vector(7 downto 0) := "00000000";
  signal ALUO           : std_logic_vector(7 downto 0) := "00000000";
  signal ALUZF          : std_logic := '0';
  signal RegWriteAddr   : std_logic_vector(3 downto 0) := "0000";
  signal RegWriteData   : std_logic_vector(7 downto 0) := "00000000";
  signal RegWriteEnable : std_logic := '0';
  signal RegReadAddrA   : std_logic_vector(3 downto 0) := "0000";
  signal RegReadDataA   : std_logic_vector(7 downto 0) := "00000000";
  signal RegReadAddrB   : std_logic_vector(3 downto 0) := "0000";
  signal RegReadDataB   : std_logic_vector(7 downto 0) := "00000000";
  signal RegReadAddrC   : std_logic_vector(3 downto 0) := "0000";
  signal RegReadDataC   : std_logic_vector(7 downto 0) := "00000000";
  component ProgramCounter is
    port (
      Clock   : in  std_logic;
      JumpFlag: in  std_logic;
      JumpAddr: in  std_logic_vector(7 downto 0);
      Addr    : out std_logic_vector(7 downto 0)
    );
  end component;
  component InstractionMemory is
    port (
      Addr: in  std_logic_vector(7 downto 0);
      Data: out std_logic_vector(23 downto 0)
    );
  end component;
  component ALU is
    port (
      Ctrl   : in  std_logic_vector(3 downto 0);
      DataInA: in  std_logic_vector(7 downto 0);
      DataInB: in  std_logic_vector(7 downto 0);
      DataInC: in  std_logic_vector(7 downto 0);
      ALUO   : out std_logic_vector(7 downto 0);
      ZF     : out std_logic
    );
  end component;
  component Reg is
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
  end component;
  component Hex is
    port (
      ValIn : in  std_logic_vector(3 downto 0);
      HexOut: out std_logic_vector(6 downto 0)
    );
  end component;
begin
  Clock <= Key(0);
  JumpFlag <= ALUZF and InstractionData(22);
  JumpAddr <= InstractionData(5) & InstractionData(5) & InstractionData(5 downto 0);
  MapProgramCounter: ProgramCounter port map (Clock, JumpFlag, JumpAddr, InstractionAddr);
  MapInstractionMemory: InstractionMemory port map (InstractionAddr, InstractionData);
  ALUCtrl <= InstractionData(21 downto 18);
  ALUDataInA <= RegReadDataA;
  ALUDataInB <= RegReadDataB when InstractionData(23) = '0' else InstractionData(5) & InstractionData(5) & InstractionData(5 downto 0);
  ALUDataInC <= SW(4 downto 0) & KEY(3 downto 1);
  MapALU: ALU port map (ALUCtrl, ALUDataInA, ALUDataInB, ALUDataInC, ALUO, ALUZF);
  RegWriteAddr <= InstractionData(9 downto 6);
  RegWriteData <= ALUO;
  RegWriteEnable <= '1';
  RegReadAddrA <= InstractionData(17 downto 14);
  RegReadAddrB <= InstractionData(13 downto 10);
  RegReadAddrC <= SW(9 downto 6);
  MapReg: Reg port map (Clock, RegWriteAddr, RegWriteData, RegWriteEnable, RegReadAddrA, RegReadDataA, RegReadAddrB, RegReadDataB, RegReadAddrC, RegReadDataC);
  MapHex0: Hex port map (RegReadDataC(3 downto 0), Hex0);
  MapHex1: Hex port map (RegReadDataC(7 downto 4), Hex1);
  MapHex4: Hex port map (InstractionAddr(3 downto 0), Hex4);
  MapHex5: Hex port map (InstractionAddr(7 downto 4), Hex5);
end main;
