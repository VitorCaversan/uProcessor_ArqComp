library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_count_one is
    port (
        clk      : in std_logic;
        write_en : in std_logic;
        reset    : in std_logic;
        output_pc: out unsigned (15 downto 0)
    );
end entity;

architecture rtl of pc_count_one is
    component program_counter is
        port
        (
            data_in:                   in unsigned (15 downto 0);
            clk, write_en, reset:      in std_logic;
            data_out:                  out unsigned (15 downto 0)
        );
    end component;

    component count_one is
        port
        (
            data_pc:  in unsigned (15 downto 0);
            clk:      in std_logic;
            data_out: out unsigned (15 downto 0)
        );
    end component;

    signal data_out_pc_sig, data_out_count_sig: unsigned (15 downto 0);

begin

    pc: program_counter port map (data_in => data_out_count_sig, clk => clk, write_en => write_en, reset => reset, data_out => data_out_pc_sig);
    count: count_one port map (data_pc => data_out_pc_sig, clk => clk, data_out => data_out_count_sig);

    output_pc <= data_out_pc_sig;

end architecture rtl;