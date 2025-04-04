library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Hex is
  port (
    ValIn : in  std_logic_vector(3 downto 0);
    HexOut: out std_logic_vector(6 downto 0)
  );
end Hex;

architecture main of Hex is
begin
  HexOut <= "1000000" WHEN ValIn = "0000" ELSE
            "1111001" WHEN ValIn = "0001" ELSE
            "0100100" WHEN ValIn = "0010" ELSE
            "0110000" WHEN ValIn = "0011" ELSE
            "0011001" WHEN ValIn = "0100" ELSE
            "0010010" WHEN ValIn = "0101" ELSE
            "0000010" WHEN ValIn = "0110" ELSE
            "1111000" WHEN ValIn = "0111" ELSE
            "0000000" WHEN ValIn = "1000" ELSE
            "0010000" WHEN ValIn = "1001" ELSE
            "0001000" WHEN ValIn = "1010" ELSE
            "0000011" WHEN ValIn = "1011" ELSE
            "1000110" WHEN ValIn = "1100" ELSE
            "0100001" WHEN ValIn = "1101" ELSE
            "0000110" WHEN ValIn = "1110" ELSE
            "0001110" WHEN ValIn = "1111" ELSE (OTHERS => '0');
end main;
