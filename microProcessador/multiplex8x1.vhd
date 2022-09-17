library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplex8x1 is
    port(
        entr0, entr1, entr2, entr3, entr4, entr5, entr6, entr7: in std_logic;
        selec0, selec1, selec2:                                 in std_logic;
        output:                                                 out std_logic
    );
end entity multiplex8x1;
architecture rtl of multiplex8x1 is
begin
    output <= entr0 when selec2='0' and selec1='0' and selec0='0' else
              entr1 when selec2='0' and selec1='0' and selec0='1' else
              entr2 when selec2='0' and selec1='1' and selec0='0' else
              entr3 when selec2='0' and selec1='1' and selec0='1' else
              entr4 when selec2='1' and selec1='0' and selec0='0' else
              entr5 when selec2='1' and selec1='0' and selec0='1' else
              entr6 when selec2='1' and selec1='1' and selec0='0' else
              entr7 when selec2='1' and selec1='1' and selec0='1' else
              '0';
end architecture rtl;