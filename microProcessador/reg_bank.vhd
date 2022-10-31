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
        data_in:                  in unsigned (14 downto 0);
        write_en, clk, reset:     in std_logic;
        reg_data_a, reg_data_b:   out unsigned (14 downto 0)
    );
end entity;

architecture rtl of reg_bank is
    component reg_15_bits is
        port
        (
            data_in  : IN unsigned (14 downto 0);
            clk      : IN std_logic ;
            reset    : IN std_logic ;
            write_en : IN std_logic ;
            data_out : OUT unsigned (14 downto 0)
        );
    end component;

    signal data_out_0, data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7: unsigned (14 downto 0);
    signal write_en_0, write_en_1, write_en_2, write_en_3, write_en_4, write_en_5, write_en_6, write_en_7: std_logic;
    
begin
    reg_0: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_0, data_out=>data_out_0);
    reg_1: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_1, data_out=>data_out_1);
    reg_2: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_2, data_out=>data_out_2);
    reg_3: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_3, data_out=>data_out_3);
    reg_4: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_4, data_out=>data_out_4);
    reg_5: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_5, data_out=>data_out_5);
    reg_6: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_6, data_out=>data_out_6);
    reg_7: reg_15_bits port map(data_in=>data_in, clk=>clk, reset=>reset, write_en=>write_en_7, data_out=>data_out_7);
    
    reg_data_a <= data_out_0 when selec_reg_a = "000" else
                  data_out_1 when selec_reg_a = "001" else
                  data_out_2 when selec_reg_a = "010" else
                  data_out_3 when selec_reg_a = "011" else
                  data_out_4 when selec_reg_a = "100" else
                  data_out_5 when selec_reg_a = "101" else
                  data_out_6 when selec_reg_a = "110" else
                  data_out_7 when selec_reg_a = "111" else
                  "000000000000000";
                
    reg_data_b <= data_out_0 when selec_reg_b = "000" else
                  data_out_1 when selec_reg_b = "001" else
                  data_out_2 when selec_reg_b = "010" else
                  data_out_3 when selec_reg_b = "011" else
                  data_out_4 when selec_reg_b = "100" else
                  data_out_5 when selec_reg_b = "101" else
                  data_out_6 when selec_reg_b = "110" else
                  data_out_7 when selec_reg_b = "111" else
                  "000000000000000";

    write_en_0 <= '0'; -- Always connected to GND
    write_en_1 <= write_en when selec_reg_write = "001" else '0';
    write_en_2 <= write_en when selec_reg_write = "010" else '0';
    write_en_3 <= write_en when selec_reg_write = "011" else '0';
    write_en_4 <= write_en when selec_reg_write = "100" else '0';
    write_en_5 <= write_en when selec_reg_write = "101" else '0';
    write_en_6 <= write_en when selec_reg_write = "110" else '0';
    write_en_7 <= write_en when selec_reg_write = "111" else '0';

    
end architecture rtl;