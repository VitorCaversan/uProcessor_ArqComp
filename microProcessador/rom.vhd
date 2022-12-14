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
        0 => B"000_001000000100", -- move $1,$0
        1 => B"010_010000000010", -- moveq $2,2
        2 => B"010_011000100000", -- moveq $3,32
        3 => B"001_001000000001", -- addi $1,1
        4 => B"000_001001000111", -- move #$1,$1
        5 => B"000_001011000101", -- cmp $1,$3
        6 => B"101_000001111101", -- blt -3 --
        7 => B"001_010000000010", -- addi $2,2
        8 => B"000_010000000111", -- move #$2,$0
        9 => B"000_010011000101",-- cmp $2,$3
        10 => B"101_000001111101",-- blt -3
        11 => B"010_010000000011",-- moveq $2,3
        12 => B"001_010000000011",-- addi $2,3
        13 => B"000_010000000111",-- move #$2,$0
        14 => B"000_010011000101",-- cmp $2,$3
        15 => B"101_000001111101",-- blt -3
        16 => B"010_010000000101",-- moveq $2,5
        17 => B"001_010000000101",-- addi $2,5
        18 => B"000_010000000111",-- move #$2,$0
        19 => B"000_010011000101",-- cmp $2,$3
        20 => B"101_000001111101",-- blt -3
        21 => B"010_010000000111",-- moveq $2,7
        22 => B"001_010000000111",-- addi $2,7
        23 => B"000_010000000111",-- move #$2,$0
        24 => B"000_010011000101",-- cmp $2,$3
        25 => B"101_000001111101",-- blt -3
        26 => B"010_001000000010",-- moveq $1,2
        27 => B"000_100001000110",-- move $4,#$1
        28 => B"001_001000000001",-- addi $1,1
        29 => B"000_001011000101",-- cmp $1, $3
        30 => B"101_000001111101",-- blt -3
        31 => B"000_000000000000",-- NOP
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