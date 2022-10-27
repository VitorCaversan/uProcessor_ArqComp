library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
    port
    (
        opcode:            in unsigned (2 downto 0);
        clk, reset:        in std_logic;
        pc_source:         out std_logic; -- +1 or jump
        rom_read_en:       out std_logic;
        reg_inst_read_en:  out std_logic;
        reg_read_en:       out std_logic;
        reg_write_en:      out std_logic;
        alu_operation:     out unsigned(1 downto 0)
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
    
    pc_source        <= '0' when opcode = "111" else
                        '1';
    rom_read_en      <= '1' when output_stt_machine_sig = "00" else
                        '0';
    reg_inst_read_en <= '1' when output_stt_machine_sig = "01" else
                        '0';
    reg_read_en      <= '1' when output_stt_machine_sig = "10" else
                        '0';
    reg_write_en     <= '0' when opcode = "111" else
                        '1';
    alu_operation    <= "00" when opcode = "000" else
                        "10" when opcode = "111" else
                        "01"; -- opcodes
    

end architecture rtl;