library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned(11 downto 0);
        data_out: out unsigned(14 downto 0)
    );
end entity rom;

architecture rtl of rom is
    type mem is array (0 to 4095) of unsigned(14 downto 0);
    constant data_rom: mem := (
        0 => "000_000011011110",
        1 => "000_000011110000",
        2 => "000_000111111110",
        3 => "000_000011001010",
        4 => "111_000000000000",
        5 => "000_111111111111",
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