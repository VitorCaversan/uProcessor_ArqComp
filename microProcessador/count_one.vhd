library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity count_one is
   port
   (
      data_pc:  in unsigned (15 downto 0);
      clk:      in std_logic;
      data_out: out unsigned (15 downto 0)
   );
end entity count_one;

architecture rtl of count_one is
   signal counting: unsigned (15 downto 0);
begin
   process(clk)
   begin
      if rising_edge(clk) then
         counting <= data_pc + "0000000000000001";
      end if;
   end process;

data_out <= counting;

end architecture rtl;

