library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity program_counter is
   port
   (
      data_in:                   in unsigned (11 downto 0);
      clk, write_en, reset:      in std_logic;
      data_out:                  out unsigned (11 downto 0)
   );
end entity program_counter;

architecture rtl of program_counter is
   signal data_sig : unsigned (11 downto 0);
   
begin
   
   process(clk, reset, write_en)
   begin
       if reset='1' then 
           data_sig <= "000000000000";
       elsif write_en='1' then
           if rising_edge(clk) then
               data_sig <= data_in;
           end if;
       end if;
   end process;
   
   data_out <= data_sig;
end architecture rtl;
