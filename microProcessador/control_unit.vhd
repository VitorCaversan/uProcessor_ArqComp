library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control_unit is
    port
    (
        clk, reset : in std_logic;
        data_out_cu: out unsigned (15 downto 0)
    );
end entity;

architecture rtl of control_unit is
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

    component rom is
        port
        (
            clk: in std_logic;
            address: in unsigned(15 downto 0);
            data_out: out unsigned(19 downto 0)
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
    signal data_out_pc:            unsigned (15 downto 0);
    signal output_state_sig:       std_logic;
    signal clk_count_one_rom_sig:  std_logic;

begin


end architecture rtl;