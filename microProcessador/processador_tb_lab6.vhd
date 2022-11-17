library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processador_tb_lab6 is
end entity processador_tb_lab6;

architecture rtl of processador_tb_lab6 is
    component uProcessor_lab6 is
        port
        (
            clk, reset : in std_logic;
            state      : out unsigned (1 downto 0);
            progamC    : out unsigned (6 downto 0);
            instruction: out unsigned (14 downto 0);
            regA_data, regB_data : out unsigned (14 downto 0);
            alu_output  : out unsigned (14 downto 0)
        );
    end component;

    constant time_period: time := 100 fs;

    signal clk, reset, finished: std_logic;
    signal state: unsigned (1 downto 0);
    signal programC: unsigned (6 downto 0);
    signal instruction, regA_data, regB_data, alu_output: unsigned (14 downto 0);
begin

    uut: uProcessor_lab6 port map
        (
            clk         => clk,
            reset       => reset,
            state       => state,
            progamC     => programC,
            instruction => instruction,
            regA_data   => regA_data,
            regB_data   => regB_data,
            alu_output  => alu_output
        );

    reset_global: process
    begin
        reset <= '1';
        wait for time_period/4;
        reset <= '0';
        wait;
    end process;
    
    simulation_time: process
    begin
        wait for 1 ns;
        finished <= '1';
        wait;
    end process;
    
    clock_behavior: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for time_period/2;
            clk <= '1';
            wait for time_period/2;
        end loop;
        wait;
    end process;

end architecture rtl;