library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_rom is
    port
    (
        clk, write_en, reset : in std_logic;
        data_out_rom         : out unsigned (19 downto 0)
    );
end entity pc_rom;

architecture rtl of pc_rom is
    component pc_count_one is
        port
        (
            clk      : in std_logic;
            write_en : in std_logic;
            reset    : in std_logic;
            output_pc: out unsigned (15 downto 0)
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

    signal output_pc_sig: unsigned (15 downto 0);

    begin
        pc: pc_count_one port map(clk => clk, write_en => write_en, reset => reset, output_pc => output_pc_sig);
        read_only_memory: rom port map(clk => clk, address => output_pc_sig, data_out => data_out_rom);

end architecture rtl;