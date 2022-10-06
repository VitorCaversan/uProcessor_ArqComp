library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned(7 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity rom;

architecture rtl of rom is
    type mem is array (0 to 255) of unsigned(15 downto 0);
    constant data_rom: mem := (
        0 => "0101010101010101",
        1 => "1010101010101010",
        2 => "1100110011001100",
        3 => "0011001100110011",
        others => (others => '0')
        );
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            data_out <= data_rom(to_integer(address));
        end if;
    end process;
end architecture rtl;