library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula is
   port(
      a,b:             in  unsigned(15 downto 0);
      selec:           in  unsigned(1 downto 0);
      output:          out unsigned(15 downto 0);
      equal, greater_a, a_negative, b_negative: out std_logic
   );
end entity;

architecture rtl of ula is
   begin
      output <= a+b when selec="00"                            else
                a-b when selec="01"                            else
                a(15 downto 8) & b(7 downto 0) when selec="10" else -- Concatenates aMSB & bLSB
                b(15 downto 8) & a(7 downto 0) when selec="11" else -- Concatenates bMSB & aLSB
                "0000000000000000";

      equal <= '1' when a=b else
               '0';
      greater_a <= '1' when a>b else
                   '0';
                   
      a_negative <= a(15);
      b_negative <= b(15);
end architecture rtl;
