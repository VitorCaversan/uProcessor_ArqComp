library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_15_bits is
    port
    (
        data_in:              in unsigned (14 downto 0);
        clk, reset, write_en: in std_logic;
        data_out:             out unsigned (14 downto 0)  
    );
end entity reg_15_bits;

architecture rtl of reg_15_bits is
    signal registring: unsigned (14 downto 0);
begin
    
    process(clk, reset, write_en)
    begin
        if reset='1' then 
            registring <= "000000000000000";
        elsif write_en='1' then
            if rising_edge(clk) then
                registring <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= registring;
end architecture rtl;