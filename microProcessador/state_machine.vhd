library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
   port
   (
      clk, reset: in std_logic;
      output    : out std_logic
   );
end entity;

architecture rtl of state_machine is
signal state: std_logic;
begin
   process (clk, reset)
   begin
      if reset='1' then
         state <= '0';
      elsif rising_edge(clk) then
         state <= not state;
      end if;
   end process;
   output <= state;

end architecture;
