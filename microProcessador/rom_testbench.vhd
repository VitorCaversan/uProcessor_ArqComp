library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_testbench is
end entity rom_testbench;

architecture rtl of rom_testbench is
    component rom is 
        port(
            clk       : in std_logic;
            address   : in unsigned (15 downto 0);
            data_out  : out unsigned (19 downto 0)
        );
    end component;


    signal clk          : std_logic;
    signal address      : unsigned (15 downto 0);
    signal data_out     : unsigned (19 downto 0);
    signal finish       : std_logic := '0';
    constant time_period: time := 50 ns; 

begin
    uut: rom port map(
        clk => clk,
        address => address,
        data_out => data_out
    );
    
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
        wait for 2*time_period;
        address <= "0000000000000000";
        wait for 2*time_period;
        address <= "0000000000000001";
        wait for 2*time_period;
        address <= "0000000000000010";
        wait for 2*time_period;
        address <= "0000000000000011";
        wait for 2*time_period;
        address <= "0000000000001111";
        wait for 2*time_period;
        address <= "0000000000101111";
        wait;
    end process;

end architecture;