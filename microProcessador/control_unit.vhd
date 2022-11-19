library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
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
end entity control_unit;

architecture rtl of control_unit is
    component state_machine is 
        port
        (
            clk, reset: in std_logic;
            output    : out unsigned (1 downto 0)
        );
    end component;
    
    signal output_stt_machine_sig: unsigned (1 downto 0);
    
begin
    stt_machine: state_machine port map (clk => clk, reset => reset, output => output_stt_machine_sig);
    
    output_stt_machine <= output_stt_machine_sig;
    pc_source        <= "000" when opcode = "111" else
                        "001" when opcode = "100" else
                        "010" when opcode = "101" else
                        "011" when opcode = "110" else
                        "100";
    pc_write_en      <= '1' when output_stt_machine_sig = "00" else
                        '0';
    reg_inst_write_en<= '1' when output_stt_machine_sig = "00" else
                        '0';
    flags_write_en     <= '1' when (opcode /= "111" and opcode /= "100" and opcode /= "101" and opcode /= "110") and output_stt_machine_sig = "10" else
                        '0';
    ula_src_b        <= "00" when opcode = "000" else
                        "10" when opcode = "101" else
                        "01";
    alu_operation    <= "00" when opcode = "000" else
                        "10" when opcode = "111" else
                        "01"; -- opcodes

    -- Done for lab7: making a RAM
    reg_bank_data_in_mux <= '1' when opcode = "000" and funct = "110" else
                            '0';
    ram_write_en         <= '1' when opcode = "000" and funct = "111" else
                            '0';

end architecture rtl;