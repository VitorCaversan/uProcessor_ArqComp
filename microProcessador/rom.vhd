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
        2 => B"010_011000000101", -- moveq $3,5
        3 => B"010_100000000110", -- moveq $4,6
        4 => B"000_100011000001", -- add $4,$3
        5 => B"001_011000000001", -- addi $3,1
        6 => B"000_011111000101", -- cmp $3,$7
        7 => B"000_111011000111", -- move #$7,$3 --
        8 => B"010_111000000010", -- moveq $7,2
        9 => B"000_111100000111", -- move #$7,$4
        10 => B"010_111000010000",-- moveq $7,16
        11 => B"000_111111000111",-- move #$7,$7
        12 => B"000_011111000110",-- move $3,#$7
        13 => B"010_111000000010",-- moveq $7,2
        14 => B"000_100111000110",-- move $4,#$7
        15 => B"010_111000011110",-- moveq $7,30
        16 => B"000_101111000110",-- move $5,#$7
        17 => B"111_000000000110",-- jmp 6
        18 => B"000_000000000000",
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