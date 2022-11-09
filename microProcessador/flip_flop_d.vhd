library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flip_flop_d is
    port
    (
        data_in:    in std_logic;
        clk, reset: in std_logic;
        data_out:   out std_logic
    );
end entity flip_flop_d;

architecture rtl of flip_flop_d is
    signal in_value: std_logic;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            in_value <= '0';
        elsif(rising_edge(clk)) then
            in_value <= data_in;
        end if;
    end process;

    data_out <= in_value;
end architecture rtl;
