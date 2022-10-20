library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_testbench is
end entity;

architecture rtl of state_machine_testbench is
   component state_machine is
      port
      (
         clk, reset: in std_logic;
         output: out std_logic
      );
   end component;

   signal clk, output  : std_logic;
   signal finish, reset: std_logic;
   constant time_period: time := 50 ns;

begin
   uut: state_machine port map
   (
      clk => clk,
      reset => reset,
      output => output
   );

   reset_global:
   process
   begin
      reset <= '1';
      wait for time_period;
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
end architecture; 