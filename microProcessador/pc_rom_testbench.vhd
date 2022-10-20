library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_rom_testbench is
end entity;

architecture rtl of pc_rom_testbench is
    component pc_rom is
        port
        (
            clk, write_en, reset : in std_logic;
            data_out_rom         : out unsigned (19 downto 0)
        );
    end component;

    signal clk, write_en: std_logic;
    signal finish, reset: std_logic;
    signal data_out_rom : unsigned (19 downto 0); 
    constant time_period: time := 50 ns;
    
    begin
    uut: pc_rom port map
    (
        clk       => clk,
        write_en  => write_en,
        reset     => reset,
        data_out_rom => data_out_rom
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
end architecture rtl;