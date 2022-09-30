library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uProcessor is
    port(
      selec_ula_action:                         in unsigned (1 downto 0);
      ula_src_b:                                in unsigned (1 downto 0);
      selec_reg_a, selec_reg_b:                 in unsigned (2 downto 0);
      selec_reg_write:                          in unsigned (2 downto 0);
      write_reg_en, clk, reset:                 in std_logic;
      output_ula, output_ula_2:                 out unsigned(15 downto 0);
      equal, greater_a, a_negative, b_negative: out std_logic
    );
end entity uProcessor;

architecture rtl of uProcessor is
    component reg_bank is
        port
        (
            selec_reg_a     : IN unsigned (2 downto 0);
            selec_reg_b     : IN unsigned (2 downto 0);
            selec_reg_write : IN unsigned (2 downto 0);
            data_in         : IN unsigned (15 downto 0);
            write_en        : IN std_logic ;
            clk             : IN std_logic ;
            reset           : IN std_logic ;
            reg_data_a      : OUT unsigned (15 downto 0);
            reg_data_b      : OUT unsigned (15 downto 0)
        );
    end component;
    
    component ula is
        port
        (
            a          : IN unsigned (15 downto 0);
            b          : IN unsigned (15 downto 0);
            selec      : IN unsigned (1 downto 0);
            output     : OUT unsigned (15 downto 0);
            output2    : out unsigned(15 downto 0);
            equal      : OUT std_logic ;
            greater_a  : OUT std_logic ;
            a_negative : OUT std_logic ;
            b_negative : OUT std_logic
        );
    end component;
    
    signal reg_data_a_sig, reg_data_b_sig, src_b_mux_output, output_ula_sig: unsigned (15 downto 0);
    
begin
    register_bank: reg_bank port map(selec_reg_a=>selec_reg_a, selec_reg_b=>selec_reg_b, selec_reg_write=>selec_reg_write, data_in=>output_ula_sig, write_en=>write_reg_en, clk=>clk, reset=>reset, reg_data_a=>reg_data_a_sig, reg_data_b=>reg_data_b_sig);
    arithmetic_lu: ula port map(a=>reg_data_a_sig, b=>src_b_mux_output, selec=>selec_ula_action, output=> output_ula_sig, output2=> output_ula_2, equal=> equal, greater_a=> greater_a, a_negative=> a_negative, b_negative=> b_negative);

    
    output_ula <= output_ula_sig;
    
    src_b_mux_output <= reg_data_b_sig     when ula_src_b = "00" else
                        "0000000000000100" when ula_src_b = "01" else
                        "0000000000000000";
    
end architecture rtl;