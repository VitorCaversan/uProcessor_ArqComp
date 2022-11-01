library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        clk: in std_logic;
        address: in unsigned(6 downto 0);
        data_out: out unsigned(14 downto 0)
    );
end entity rom;

architecture rtl of rom is
    type mem is array (0 to 127) of unsigned(14 downto 0);
    constant data_rom: mem := (
        0 => B"000_000000000000",
        1 => B"010_011000000101", -- moveq $3,5
        2 => B"010_100000001000", -- moveq $4,8
        3 => B"000_101011000001", -- add $5,$3
        4 => B"000_101100000001", -- add $5,$4
        5 => B"001_101111111111", -- addi $5,-1;
        6 => B"111_000000010100", -- jump 20
        7 => B"001_111111111111",
        8 => B"001_111111111111",
        9 => B"001_111111111111",
        10 => B"001_111111111111",
        11 => B"001_111111111111",
        12 => B"001_111111111111",
        13 => B"001_111111111111",
        14 => B"001_111111111111",
        15 => B"001_111111111111",
        16 => B"001_111111111111",
        17 => B"001_111111111111",
        18 => B"001_111111111111",
        19 => B"001_111111111111",
        20 => B"000_011101000100", -- move $3,$5
        21 => B"111_000000000011", -- jump 3
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