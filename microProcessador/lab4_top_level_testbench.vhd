library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab4_top_level_testbench is
end entity lab4_top_level_testbench;

architecture rtl of lab4_top_level_testbench is
    component lab4_top_level is
        port
        (
            clk                : IN std_logic ;
            reset              : IN std_logic ;
            data_out_top_level : OUT unsigned (19 downto 0)
        );
    end component;
    
    signal clk, reset, finish: std_logic;
    signal data_out_top_level: unsigned (19 downto 0);
    constant time_period: time := 50 ns;
    
begin

   uut: lab4_top_level port map
   (
      clk => clk,
      reset => reset,
      data_out_top_level => data_out_top_level
   );

   reset_global:
   process
   begin
      reset <= '1';
      wait for time_period/2;
      reset <= '0';
      wait;
   end process;

   simulation_time:
   process
   begin
      wait for 1000 ns;
         finish <= '1';
      wait;
   end process;

   time_clk:
   process
   begin
      while finish /= '1' loop
         clk <= '0';
         wait for time_period/2;
         clk <= '1';
         wait for time_period/2;
      end loop;
      wait;
    end process;

    process
    begin
       wait for 2*time_period; -- visualiza a alteração de estado a cada 2 clocks
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait for 2*time_period;
       wait;
    end process;
end architecture rtl;