library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flip_flop_d is
    port
    (
        data_in:            in std_logic;
        clk, reset: in std_logic;
        data_out:           out std_logic
    )
end entity

architecture rtl of flip_flop_d is
begin
    process(clk)
    begin
        if reset = '1' then
            data_out <= '0';
        elsif(rising_edge(clk)) then
            data_out <= data_in;
        end if
    end process
end architecture rtl;
