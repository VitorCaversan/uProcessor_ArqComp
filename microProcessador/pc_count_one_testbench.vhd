library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_count_one_testbench is
end entity;

architecture rtl of pc_count_one_testbench is
    component pc_count_one is
        port
        (
            clk      : in std_logic;
            write_en : in std_logic;
            reset    : in std_logic;
            output_pc: out unsigned (15 downto 0) 
        );
    end component;
        
    signal clk, write_en: std_logic;
    signal finish, reset: std_logic;
    signal output_pc    : unsigned (15 downto 0); 
    constant time_period: time := 50 ns;
    
    begin
    uut: pc_count_one port map
    (
        clk       => clk,
        write_en  => write_en,
        reset     => reset,
        output_pc => output_pc
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

    write_en_process:
    process
    begin
        write_en <= '1';
        wait;
    end process;

    process
    begin
        wait for time_period; -- visualiza o soma 1 a cada 2 clocks
        wait for time_period;
        wait for time_period;
        wait for time_period;
        wait for time_period;
        wait for time_period;
        wait for time_period;
        wait for time_period;
        wait for time_period;
        wait;
    end process;

end architecture;