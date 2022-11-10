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
        1 => B"010_111000011110", -- moveq $7,30
        2 => B"010_011000000000", -- moveq $3,0
        3 => B"010_100000000000", -- moveq $4,0
        4 => B"000_100011000001", -- add $4,$3
        5 => B"001_011000000001", -- addi $3,1
        6 => B"000_011111000101", -- cmp $3,$7
        7 => B"101_111111111101", -- blt -3
        8 => B"000_000000000000", 
        9 => B"000_101100000100", -- move $5,$4
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