library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
    port
    (
        opcode:             in unsigned (2 downto 0);
        clk, reset:         in std_logic;
        output_stt_machine: out unsigned(1 downto 0);
        pc_source:          out unsigned(1 downto 0); -- +1 or jump or branch
        pc_write_en:        out std_logic;
        reg_inst_write_en:  out std_logic;
        reg_write_en:       out std_logic;
        ula_src_b:          out std_logic;
        alu_operation:      out unsigned(1 downto 0)
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
    pc_source        <= "00" when opcode = "111" else
                        "01" when opcode = "100" else
                        "10" when opcode = "101" else
                        "11";
    pc_write_en      <= '1' when output_stt_machine_sig = "00" else
                        '0';
    reg_inst_write_en<= '1' when output_stt_machine_sig = "00" else
                        '0';
    reg_write_en     <= '1' when (opcode /= "111" or opcode /= "100" or opcode /= "101") and output_stt_machine_sig = "10" else
                        '0';
    ula_src_b        <= '0' when opcode = "000" else
                        '1';
    alu_operation    <= "00" when opcode = "000" else
                        "10" when opcode = "111" else
                        "01"; -- opcodes

end architecture rtl;