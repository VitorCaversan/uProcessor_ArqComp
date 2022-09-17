library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplex8x1_testbench is
end entity;

architecture rtl of multiplex8x1_testbench is
    component multiplex8x1 is
        port
        (
            entr0  : IN std_logic ;
            entr1  : IN std_logic ;
            entr2  : IN std_logic ;
            entr3  : IN std_logic ;
            entr4  : IN std_logic ;
            entr5  : IN std_logic ;
            entr6  : IN std_logic ;
            entr7  : IN std_logic ;
            selec0 : IN std_logic ;
            selec1 : IN std_logic ;
            selec2 : IN std_logic ;
            output : OUT std_logic
        );
    end component;

    signal entr0, entr1, entr2, entr3, entr4, entr5, entr6, entr7, selec0, selec1, selec2, output: std_logic;

begin
    uut: multiplex8x1 port map (
        entr0 => entr0,
        entr1 => entr1,
        entr2 => entr2,
        entr3 => entr3,
        entr4 => entr4,
        entr5 => entr5,
        entr6 => entr6,
        entr7 => entr7,
        selec0 => selec0,
        selec1 => selec1,
        selec2 => selec2,
        output => output
    );
    
    process
    begin
        entr0 <= '0';
        entr1 <= '0';
        entr5 <= '0';
        entr3 <= '1';
        entr7 <= '1';
        entr2 <= '0';
        entr4 <= '0';
        entr6 <= '0';
        selec0 <= '1';
        selec1 <= '1';
        selec2 <= '1';
        wait for 50 ns;
        entr2 <= '1';
        entr4 <= '0';
        entr6 <= '0';
        selec0 <= '0';
        selec1 <= '1';
        selec2 <= '0';
        wait for 50 ns;
        entr2 <= '0';
        entr4 <= '1';
        entr6 <= '0';
        selec0 <= '0';
        selec1 <= '0';
        selec2 <= '1';
        wait for 50 ns;
        entr2 <= '1';
        entr4 <= '1';
        entr6 <= '0';
        selec0 <= '1';
        selec1 <= '1';
        selec2 <= '0';
        wait for 50 ns;
        entr2 <= '0';
        entr4 <= '0';
        entr6 <= '1';
        selec0 <= '0';
        selec1 <= '0';
        selec2 <= '1';
        wait for 50 ns;
        entr2 <= '1';
        entr4 <= '0';
        entr6 <= '1';
        selec0 <= '1';
        selec1 <= '0';
        selec2 <= '1';
        wait for 50 ns;
        entr2 <= '0';
        entr4 <= '1';
        entr6 <= '1';
        selec0 <= '0';
        selec1 <= '1';
        selec2 <= '1';
        wait for 50 ns;
        entr2 <= '1';
        entr4 <= '1';
        entr6 <= '1';
        selec0 <= '1';
        selec1 <= '1';
        selec2 <= '1';
        wait;
    end process;

end architecture rtl;