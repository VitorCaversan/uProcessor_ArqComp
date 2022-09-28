-- 2 barramentos selec para saber quais registradores serão lidos
-- barramento para o valor a ser escrito
-- barramento selec para escolher qual registrador será escrito
-- write_en 
-- clk
-- reset
-- 2 barramentos de saída com os dados dos registradores lidos

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_bank is
    port
    (
        selec_reg_a, selec_reg_b: in unsigned (2 downto 0);
        selec_reg_write:          in unsigned (2 downto 0);
        data_in:                  in unsigned (15 downto 0);
        write_en, clk, reset:     in std_logic;
        reg_data_a, reg_data_b:   out unsigned (15 downto 0)
    );
end entity;

architecture rtl of reg_bank is
begin

    

end architecture rtl;