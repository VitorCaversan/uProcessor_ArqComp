library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
   port
   (
      clk, reset: in std_logic;
      output    : out unsigned (1 downto 0)
   );
end entity;

architecture rtl of state_machine is
signal state: unsigned (1 downto 0);
begin
   process (clk, reset)
   begin
      if reset='1' then
         state <= "00";
      elsif rising_edge(clk) then
         if state = "10" then
            state <= "00";
         else 
            state <= state+1;
         end if;
      end if;
   end process;
   output <= state;

end architecture;
