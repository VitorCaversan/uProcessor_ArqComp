library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uProcessor_lab5 is
    port(
        clk, reset: in std_logic
    );
end entity uProcessor_lab5;

architecture rtl of uProcessor_lab5 is
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
    
    component reg_bank is
        port
        (
            selec_reg_a     : IN unsigned (2 downto 0);
            selec_reg_b     : IN unsigned (2 downto 0);
            selec_reg_write : IN unsigned (2 downto 0);
            data_in         : IN unsigned (14 downto 0);
            write_en        : IN std_logic ;
            clk             : IN std_logic ;
            reset           : IN std_logic ;
            reg_data_a      : OUT unsigned (14 downto 0);
            reg_data_b      : OUT unsigned (14 downto 0)
        );
    end component;
    
    component ula is
        port
        (
            a          : IN unsigned (14 downto 0);
            b          : IN unsigned (14 downto 0);
            selec      : IN unsigned (1 downto 0);
            output     : OUT unsigned (14 downto 0);
            output2    : out unsigned(14 downto 0);
            equal      : OUT std_logic ;
            greater_a  : OUT std_logic ;
            a_negative : OUT std_logic ;
            b_negative : OUT std_logic
        );
    end component;
    
    component program_counter is
        port
        (
            data_in:                   in unsigned (11 downto 0);
            clk, write_en, reset:      in std_logic;
            data_out:                  out unsigned (11 downto 0)
        );
    end component;
    
    component rom is
        port
        (
            clk      : IN std_logic ;
            address  : IN unsigned (11 downto 0);
            data_out : OUT unsigned (14 downto 0)
        );
    end component;
    
    component control_unit is
        port
        (
            opcode           : IN unsigned (2 downto 0);
            clk              : IN std_logic ;
            reset            : IN std_logic ;
            pc_source        : OUT std_logic ;
            rom_read_en      : OUT std_logic ;
            reg_inst_read_en : OUT std_logic ;
            reg_read_en      : OUT std_logic ;
            reg_write_en     : OUT std_logic ;
            alu_operation    : OUT unsigned (1 downto 0)
        );
    end component;

    signal rom_read_en_sig:                 std_logic;
    signal rom_data_out_sig:                unsigned(14 downto 0);
    signal inst_reg_data_out_sig:           unsigned(14 downto 0);
    signal inst_reg_data_out_12_0_sig:      unsigned(11 downto 0);
    signal pc_data_in_sig, pc_data_out_sig: unsigned(11 downto 0);
    signal pc_source_sig:                   std_logic;
begin
    
    inst_register: reg_15_bits port map
                                    (
                                        data_in  => rom_data_out_sig,
                                        clk      => clk,
                                        reset    => reset,
                                        write_en => rom_read_en_sig,
                                        data_out => inst_reg_data_out_sig
                                    );

    pc: program_counter port map
                            (
                                data_in  => pc_data_in_sig,
                                clk => clk, write_en => '1', reset => reset,
                                data_out => pc_data_out_sig
                            );

    read_only_mem: rom port map
                            (
                                clk      => rom_read_en_sig,
                                address  => pc_data_out_sig,
                                data_out => rom_data_out_sig
                            );

    pc_data_in_sig <= (pc_data_out_sig + "000000000001") when pc_source_sig = '1' else
                       inst_reg_data_out_12_0_sig;
end architecture rtl;