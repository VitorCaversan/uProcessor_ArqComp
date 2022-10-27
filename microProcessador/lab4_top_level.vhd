library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lab4_top_level is
    port
    (
        clk, reset : in std_logic;
        data_out_top_level: out unsigned (19 downto 0)
    );
end entity;

architecture rtl of lab4_top_level is
    component program_counter is
        port
        (
            data_in:                   in unsigned (15 downto 0);
            clk, write_en, reset:      in std_logic;
            data_out:                  out unsigned (15 downto 0)
        );
    end component;

    component rom is
        port
        (
            clk: in std_logic;
            address: in unsigned(15 downto 0);
            data_out: out unsigned(19 downto 0)
        );
    end component;

    component control_unit is
        port
        (
            opcode: in unsigned (3 downto 0);
            cu_output: out unsigned (1 downto 0)
        );
    end component;

    component state_machine is
        port
        (
            clk, reset: in std_logic;
            output    : out std_logic
        );
    end component;

    signal data_out_rom_sig:       unsigned (19 downto 0);
    signal opcode_sig:             unsigned (3 downto 0);
    signal data_out_adress_sig:    unsigned (15 downto 0);
    signal data_out_count_one_sig: unsigned (15 downto 0);
    signal output_mux_pc_sig:      unsigned (15 downto 0);
    signal data_out_pc_sig:        unsigned (15 downto 0);
    signal cu_output_sig:          unsigned (1 downto 0);
    signal output_state_sig:       std_logic;
    signal read_from_rom:          std_logic;

begin
    pc: program_counter port map (data_in => output_mux_pc_sig, clk => clk, reset => reset, write_en => output_state_sig, data_out => data_out_pc_sig);
    read_only_mem: rom port map (clk => clk, address => data_out_pc_sig, data_out => data_out_rom_sig);
    cu: control_unit port map (opcode => opcode_sig, cu_output => cu_output_sig);
    state_m: state_machine port map (clk => read_from_rom, reset => reset, output => output_state_sig);
    
    opcode_sig <= data_out_rom_sig(19 downto 16);
    data_out_adress_sig <= data_out_rom_sig(15 downto 0);

    read_from_rom <= '1' when clk = '1' and output_state_sig = '0' else
                     '0';
    
    data_out_count_one_sig <= data_out_pc_sig + "0000000000000001";
    
    output_mux_pc_sig <= data_out_count_one_sig when cu_output_sig = "00" else
                         data_out_adress_sig    when cu_output_sig = "01" else
                         "0000000000000000";
    
    data_out_top_level <= data_out_rom_sig;
    
end architecture rtl;