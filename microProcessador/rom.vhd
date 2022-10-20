library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned(15 downto 0);
        data_out: out unsigned(19 downto 0)
    );
end entity rom;

architecture rtl of rom is
    type mem is array (0 to 65535) of unsigned(19 downto 0);
    constant data_rom: mem := (
        0 => "00000101010101010101",
        1 => "00001010101010101010",
        2 => "00001100110011001100",
        3 => "00000011001100110011",
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