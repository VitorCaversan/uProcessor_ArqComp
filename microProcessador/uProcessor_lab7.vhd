library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uProcessor_lab7 is
    port(
        clk, reset : in std_logic;
        state      : out unsigned (1 downto 0);
        progamC    : out unsigned (6 downto 0);
        instruction: out unsigned (14 downto 0);
        regA_data, regB_data : out unsigned (14 downto 0);
        alu_output : out unsigned (14 downto 0)
    );
end entity uProcessor_lab7;

architecture rtl of uProcessor_lab7 is
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
            output1    : OUT unsigned (14 downto 0);
            output2    : out unsigned(14 downto 0);
            equal      : OUT std_logic ;
            greater_a  : OUT std_logic ;
            a_negative : OUT std_logic ;
            b_negative : OUT std_logic
        );
    end component;

    component flip_flop_d is
        port
        (
            data_in:    in std_logic;
            clk, reset, write_en: in std_logic;
            data_out:   out std_logic
        );
    end component;
    
    component program_counter is
        port
        (
            data_in:                   in unsigned (6 downto 0);
            clk, write_en, reset:      in std_logic;
            data_out:                  out unsigned (6 downto 0)
        );
    end component;
    
    component rom is
        port
        (
            clk      : IN std_logic ;
            address  : IN unsigned (6 downto 0);
            data_out : OUT unsigned (14 downto 0)
        );
    end component;
    
    component control_unit is
        port
        (
            opcode:               in unsigned (2 downto 0);
            funct:                in unsigned (2 downto 0);
            clk, reset:           in std_logic;
            output_stt_machine:   out unsigned(1 downto 0);
            pc_source:            out unsigned(2 downto 0); -- +1 or jump or branch
            pc_write_en:          out std_logic;
            reg_inst_write_en:    out std_logic;
            flags_write_en:       out std_logic;
            ula_src_b:            out unsigned(1 downto 0);
            alu_operation:        out unsigned(1 downto 0);
            reg_bank_data_in_mux: out std_logic;
            ram_write_en:         out std_logic
        );
    end component;
    
    component ram is
        port
        (
            clk      : IN std_logic ;
            address  : IN unsigned (6 downto 0);
            write_en : IN std_logic ;
            data_in  : IN unsigned (14 downto 0);
            data_out : OUT unsigned (14 downto 0)
        );
    end component;

    signal rom_data_out_sig:                unsigned(14 downto 0);
    signal inst_reg_data_in_sig:            unsigned(14 downto 0);
    signal inst_reg_data_out_sig:           unsigned(14 downto 0);
    signal inst_reg_J_immediate_sig:        unsigned(6 downto 0);
    signal inst_reg_branch_d_sig:           unsigned(6 downto 0);
    signal inst_reg_I_immediate_sig:        unsigned(14 downto 0);
    signal inst_reg_opcode_sig:             unsigned(2 downto 0);
    signal inst_reg_funct_sig:              unsigned(2 downto 0);
    signal inst_reg_write_en_sig:           std_logic; -- Comes from CU
    signal pc_data_in_sig, pc_data_out_sig: unsigned(6 downto 0);
    signal pc_source_sig:                   unsigned(2 downto 0); -- Comes from CU: 00 for Jump, 01 for Immediate, 10 for +1
    signal pc_write_en_sig:                 std_logic; -- Comes from CU
    signal reg_bank_selec_reg_a_sig:        unsigned(2 downto 0);
    signal reg_bank_selec_reg_b_sig:        unsigned(2 downto 0);
    signal reg_bank_selec_reg_write_sig:    unsigned(2 downto 0);
    signal reg_bank_write_en_sig:           std_logic; -- Comes from CU
    signal reg_bank_data_in_sig:            unsigned(14 downto 0); -- Can be either an ALU output or data from RAM
    signal reg_bank_data_a_sig:             unsigned(14 downto 0);
    signal reg_bank_data_b_sig:             unsigned(14 downto 0);
    signal reg_bank_data_in_mux_sig:        std_logic;
    signal ula_output_sig, ula_output_sig2: unsigned(14 downto 0);
    signal ula_src_b_sig:                   unsigned(1 downto 0); -- Comes from CU
    signal ula_data_in_a_sig:               unsigned(14 downto 0);
    signal ula_data_in_b_sig:               unsigned(14 downto 0);
    signal ula_operation_sig:               unsigned(1 downto 0);
    signal ula_equal_sig:                   std_logic;
    signal ula_greater_a_sig:               std_logic;
    signal flag_equal_sig:                  std_logic;
    signal flag_greater_a_sig:              std_logic;
    signal flag_write_en_sig:               std_logic;
    signal ram_data_in_sig:                 unsigned(14 downto 0);
    signal ram_data_out_sig:                unsigned(14 downto 0);
    signal ram_address_sig:                 unsigned(6 downto 0);
    signal ram_write_en_sig:                std_logic;
    signal cu_ula_operation_sig:            unsigned(1 downto 0); -- Comes from CU: 00 for R, 01 for I, 10 for J.
    signal state_sig:                       unsigned(1 downto 0);
begin
    
    inst_register: reg_15_bits port map
                                    (
                                        data_in  => inst_reg_data_in_sig,
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
                                    data_in         => reg_bank_data_in_sig,
                                    write_en        => reg_bank_write_en_sig,
                                    clk             => clk,
                                    reset           => reset,
                                    reg_data_a      => reg_bank_data_a_sig,
                                    reg_data_b      => reg_bank_data_b_sig
                                );

    cu: control_unit port map
                            (
                                opcode               => inst_reg_opcode_sig,
                                funct                => inst_reg_funct_sig,
                                clk                  => clk, 
                                reset                => reset,
                                output_stt_machine   => state_sig,
                                pc_source            => pc_source_sig,
                                pc_write_en          => pc_write_en_sig,
                                reg_inst_write_en    => inst_reg_write_en_sig,
                                flags_write_en       => flag_write_en_sig,
                                ula_src_b            => ula_src_b_sig,
                                alu_operation        => cu_ula_operation_sig,
                                reg_bank_data_in_mux => reg_bank_data_in_mux_sig,
                                ram_write_en         => ram_write_en_sig
                            );

    alu: ula port map
                    (
                        a         => ula_data_in_a_sig,
                        b         => ula_data_in_b_sig,
                        selec     => ula_operation_sig,
                        output1   => ula_output_sig,
                        output2   => ula_output_sig2,
                        equal     => ula_equal_sig,
                        greater_a => ula_greater_a_sig
                    );

    flag_equal: flip_flop_d port map
                                    (
                                        data_in => ula_equal_sig,
                                        clk => clk,
                                        reset => reset,
                                        write_en => flag_write_en_sig,
                                        data_out => flag_equal_sig
                                    );

    flag_greater_a: flip_flop_d port map
                                        (
                                            data_in => ula_greater_a_sig,
                                            clk => clk,
                                            reset => reset,
                                            write_en => flag_write_en_sig,
                                            data_out => flag_greater_a_sig
                                        );

    random_access_mem: ram port map
                                (
                                    clk      => clk,
                                    address  => ram_address_sig,
                                    write_en => ram_write_en_sig,
                                    data_in  => ram_data_in_sig,
                                    data_out => ram_data_out_sig
                                );


    inst_reg_data_in_sig <= "000000000000000" when pc_source_sig = "000" or pc_source_sig = "001" or pc_source_sig = "010" or pc_source_sig = "011" else
                            rom_data_out_sig;

    pc_data_in_sig <= inst_reg_J_immediate_sig when pc_source_sig = "000" else -- absolute jump
                      (pc_data_out_sig + inst_reg_branch_d_sig)    when pc_source_sig = "001" and flag_equal_sig = '1'     else -- relative jump
                      (pc_data_out_sig + inst_reg_branch_d_sig)    when pc_source_sig = "010" and flag_greater_a_sig = '0' and flag_equal_sig = '0' else
                      (pc_data_out_sig + inst_reg_J_immediate_sig) when pc_source_sig = "011" else
                      (pc_data_out_sig + "0000001");

    inst_reg_opcode_sig      <= inst_reg_data_out_sig (14 downto 12);
    inst_reg_funct_sig       <= inst_reg_data_out_sig (2 downto 0);
    inst_reg_J_immediate_sig <= inst_reg_data_out_sig (6 downto 0); -- Immediate used for jumps
    inst_reg_I_immediate_sig <= "111111" & inst_reg_data_out_sig (8 downto 0) when inst_reg_data_out_sig(8) = '1' else
                                "000000" & inst_reg_data_out_sig (8 downto 0); -- Immediate used for alu operations
    inst_reg_branch_d_sig    <= inst_reg_data_out_sig (6 downto 0) - 1; -- Immediate used for branching

    -- Parses instruction's bits to select registers
    reg_bank_selec_reg_a_sig <= inst_reg_data_out_sig (11 downto 9);
    reg_bank_selec_reg_b_sig <= inst_reg_data_out_sig (8 downto 6);
    reg_bank_selec_reg_write_sig <= inst_reg_data_out_sig (11 downto 9);
    reg_bank_write_en_sig <= '0' when flag_write_en_sig = '0' or (inst_reg_opcode_sig = "000" and (inst_reg_funct_sig = "101" or inst_reg_funct_sig = "111" )) else
                             '1';
    reg_bank_data_in_sig <= ram_data_out_sig when reg_bank_data_in_mux_sig = '1' else
                            ula_output_sig; -- recieves data from RAM when it is a memory-move instruction, otherwise recieves ula output

    ula_data_in_a_sig <= "000000000000000" when (inst_reg_opcode_sig = "010") or (inst_reg_opcode_sig = "000" and inst_reg_funct_sig = "100") else
                        reg_bank_data_a_sig;
    ula_data_in_b_sig <= inst_reg_I_immediate_sig when ula_src_b_sig = "01" else
                         reg_bank_data_b_sig; -- Chooses what will go to ALU's data_in b

    ula_operation_sig <= "01" when (cu_ula_operation_sig = "00" and (inst_reg_funct_sig = "010" or inst_reg_funct_sig = "101")) else
                         "10" when (cu_ula_operation_sig = "00" and inst_reg_funct_sig = "011") else
                         "00"; -- What the ALU does

    ram_data_in_sig <= reg_bank_data_b_sig when ram_write_en_sig = '1' else
                       reg_bank_data_a_sig;
    ram_address_sig <= reg_bank_data_a_sig(6 downto 0) when ram_write_en_sig = '1' else
                       reg_bank_data_b_sig(6 downto 0);

    -- Top level outputs
    state       <= state_sig;
    progamC     <= pc_data_out_sig;
    instruction <= inst_reg_data_out_sig;
    regA_data   <= reg_bank_data_a_sig;
    regB_data   <= reg_bank_data_b_sig;
    alu_output  <= ula_output_sig;
end architecture rtl;