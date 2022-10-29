library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uProcessor_lab5 is
    port(
        clk, reset : in std_logic;
        state      : out unsigned (1 downto 0);
        progamC    : out unsigned (6 downto 0);
        instruction: out unsigned (14 downto 0);
        regA_data, regB_data : out unsigned (14 downto 0);
        alu_output  : out unsigned (14 downto 0)
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

    signal rom_data_out_sig:                unsigned(14 downto 0);
    signal inst_reg_data_out_sig:           unsigned(14 downto 0);
    signal inst_reg_J_immediate_sig:        unsigned(6 downto 0);
    signal inst_reg_I_immediate_sig:        unsigned(5 downto 0);
    signal inst_reg_opcode_sig:             unsigned(2 downto 0);
    signal inst_reg_funct_sig:              unsigned(2 downto 0);
    signal inst_reg_write_en_sig:           std_logic; -- Comes from CU
    signal pc_data_in_sig, pc_data_out_sig: unsigned(6 downto 0);
    signal pc_source_sig:                   std_logic; -- Comes from CU
    signal pc_write_en_sig:                 std_logic; -- Comes from CU
    signal reg_bank_selec_reg_a_sig:        unsigned(2 downto 0);
    signal reg_bank_selec_reg_b_sig:        unsigned(2 downto 0);
    signal reg_bank_selec_reg_write_sig:    unsigned(2 downto 0);
    signal reg_bank_write_en_sig:           std_logic; -- Comes from CU
    signal reg_bank_data_a_sig:             unsigned(14 downto 0);
    signal reg_bank_data_b_sig:             unsigned(14 downto 0);
    signal ula_output_sig, ula_output_sig2: unsigned(14 downto 0);
    signal ula_src_b_sig:                   std_logic; -- Comes from CU
    signal ula_data_in_b_sig:               unsigned(14 downto 0);
    signal ula_operation_sig:               unsigned(1 downto 0);
    signal cu_ula_operation_sig:            unsigned(1 downto 0); -- Comes from CU: 00 for R, 01 for I, 10 for J.
    signal state_sig:                       unsigned(1 downto 0);
begin
    
    inst_register: reg_15_bits port map
                                    (
                                        data_in  => rom_data_out_sig,
                                        clk      => clk,
                                        reset    => reset,
                                        write_en => inst_reg_write_en_sig,
                                        data_out => inst_reg_data_out_sig
                                    );

    pc: program_counter port map
                            (
                                data_in  => pc_data_in_sig,
                                clk => clk, write_en => pc_write_en_sig, reset => reset,
                                data_out => pc_data_out_sig
                            );

    read_only_mem: rom port map
                            (
                                clk      => clk,
                                address  => pc_data_out_sig,
                                data_out => rom_data_out_sig
                            );

    register_bank: reg_bank port map
                                (
                                    selec_reg_a     => reg_bank_selec_reg_a_sig,
                                    selec_reg_b     => reg_bank_selec_reg_b_sig,
                                    selec_reg_write => reg_bank_selec_reg_write_sig,
                                    data_in         => ula_output_sig,
                                    write_en        => reg_bank_write_en_sig,
                                    clk             => clk,
                                    reset           => reset,
                                    reg_data_a      => reg_bank_data_a_sig,
                                    reg_data_b      => reg_bank_data_b_sig
                                );

    cu: control_unit port map
                            (
                                opcode             => inst_reg_opcode_sig,
                                clk                => clk, 
                                reset              => reset,
                                output_stt_machine => state_sig,
                                pc_source          => pc_source_sig,
                                pc_write_en        => pc_write_en_sig,
                                reg_inst_write_en  => inst_reg_write_en_sig,
                                reg_write_en       => reg_bank_write_en_sig,
                                ula_src_b          => ula_src_b_sig,
                                alu_operation      => cu_ula_operation_sig
                            );

    alu: ula port map
                    (
                        a       => reg_bank_data_a_sig,
                        b       => ula_data_in_b_sig,
                        selec   => ula_operation_sig,
                        output  => ula_output_sig,
                        output2 => ula_output_sig2
                    );


    pc_data_in_sig <= (pc_data_out_sig + "0000001") when pc_source_sig = '1' else
                       inst_reg_J_immediate_sig;

    inst_reg_opcode_sig      <= inst_reg_data_out_sig (14 downto 12);
    inst_reg_funct_sig       <= inst_reg_data_out_sig (2 downto 0);
    inst_reg_J_immediate_sig <= inst_reg_data_out_sig (6 downto 0);
    inst_reg_I_immediate_sig <=   inst_reg_data_out_sig(5) & inst_reg_data_out_sig(5) -- Expands the value with the immediate's MSB
                                & inst_reg_data_out_sig(5) & inst_reg_data_out_sig(5)
                                & inst_reg_data_out_sig(5) & inst_reg_data_out_sig(5)
                                & inst_reg_data_out_sig(5) & inst_reg_data_out_sig(5)
                                & inst_reg_data_out_sig(5) & inst_reg_data_out_sig (5 downto 0);

    -- Parses instruction's bits to select registers
    reg_bank_selec_reg_a_sig <= inst_reg_data_out_sig (11 downto 9) when cu_ula_operation_sig = "00" else
                                inst_reg_data_out_sig (8 downto 6);
    reg_bank_selec_reg_b_sig <= inst_reg_data_out_sig (8 downto 6);
    reg_bank_selec_reg_write_sig <= inst_reg_data_out_sig (5 downto 3) when cu_ula_operation_sig = "00" else
                                    inst_reg_data_out_sig (11 downto 9);

    ula_data_in_b_sig <= inst_reg_I_immediate_sig when ula_src_b_sig = '0' else
                         reg_bank_data_b_sig; -- Chooses what will go to ALU's data_in b

    ula_operation_sig <= "01" when (cu_ula_operation_sig = "00" and inst_reg_funct_sig = "010") else
                         "10" when (cu_ula_operation_sig = "00" and inst_reg_funct_sig = "011") else
                         "00"; -- What the ALU does

    -- Top level outputs
    state       <= state_sig;
    progamC     <= pc_data_out_sig;
    instruction <= inst_reg_data_out_sig;
    regA_data   <= reg_bank_data_a_sig;
    regB_data   <= reg_bank_data_b_sig;
    alu_output  <= ula_output_sig;
end architecture rtl;