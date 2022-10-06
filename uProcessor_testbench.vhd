library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uProcessor_testbench is
end entity uProcessor_testbench;

architecture rtl of uProcessor_testbench is
    component uProcessor is
        port
        (
            selec_ula_action : IN unsigned (1 downto 0);
            ula_src_b        : IN unsigned (1 downto 0);
            selec_reg_a      : IN unsigned (2 downto 0);
            selec_reg_b      : IN unsigned (2 downto 0);
            selec_reg_write  : IN unsigned (2 downto 0);
            write_reg_en     : IN std_logic ;
            clk              : IN std_logic ;
            reset            : IN std_logic ;
            output_ula       : OUT unsigned (15 downto 0);
            output_ula_2     : OUT unsigned (15 downto 0);
            equal            : OUT std_logic ;
            greater_a        : OUT std_logic ;
            a_negative       : OUT std_logic ;
            b_negative       : OUT std_logic
        );
    end component;
    
    constant time_period: time := 100 fs;
    
    signal selec_ula_action, ula_src_b: unsigned (1 downto 0);
    signal selec_reg_a, selec_reg_b, selec_reg_write: unsigned (2 downto 0);
    signal output_ula, output_ula_2: unsigned (15 downto 0);
    signal write_reg_en, clk, reset, equal, greater_a, a_negative, b_negative, finished: std_logic;
    
begin

    uut: uProcessor port map(
        selec_ula_action=> selec_ula_action,
        ula_src_b       => ula_src_b       ,
        selec_reg_a     => selec_reg_a     ,
        selec_reg_b     => selec_reg_b     ,
        selec_reg_write => selec_reg_write ,
        write_reg_en    => write_reg_en    ,
        clk             => clk             ,
        reset           => reset           ,
        output_ula      => output_ula      ,
        output_ula_2    => output_ula_2    ,
        equal           => equal           ,
        greater_a       => greater_a       ,
        a_negative      => a_negative      ,
        b_negative      => b_negative
    );
    
    reset_global: process
    begin
        reset <= '1';
        wait for time_period;
        reset <= '0';
        wait;
    end process;
    
    simulation_time: process
    begin
        wait for 1 ns;
        finished <= '1';
        wait;
    end process;
    
    clock_behavior: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for time_period/2;
            clk <= '1';
            wait for time_period/2;
        end loop;
        wait;
    end process;


    process
    begin
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "01";
        selec_reg_a <= "000";
        selec_reg_b <= "100";
        selec_reg_write <= "000";
        write_reg_en <= '0';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "01";
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "001";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "01";
        selec_reg_a <= "001";
        selec_reg_b <= "001";
        selec_reg_write <= "000";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "00";
        selec_reg_a <= "000";
        selec_reg_b <= "001";
        selec_reg_write <= "010";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "00";
        selec_reg_a <= "010";
        selec_reg_b <= "101";
        selec_reg_write <= "111";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "01";
        selec_reg_a <= "011";
        selec_reg_b <= "100";
        selec_reg_write <= "101";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "01";
        selec_reg_a <= "000";
        selec_reg_b <= "101";
        selec_reg_write <= "100";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "00";
        selec_reg_a <= "010";
        selec_reg_b <= "100";
        selec_reg_write <= "110";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "01";
        selec_reg_a <= "110";
        selec_reg_b <= "100";
        selec_reg_write <= "011";
        write_reg_en <= '1';
        wait for 2*time_period;
        selec_ula_action <= "00";
        ula_src_b <= "00";
        selec_reg_a <= "010";
        selec_reg_b <= "100";
        selec_reg_write <= "010";
        write_reg_en <= '1';
        wait for 2*time_period;
        -- Shift_left_2_b e soma os registradores 5 e 7, guarda no 5
        selec_ula_action <= "00";
        ula_src_b <= "10";
        selec_reg_a <= "101";
        selec_reg_b <= "111";
        selec_reg_write <= "101";
        write_reg_en <= '1';
        wait for 2*time_period;
        -- Shift_left_2_b e subtrai os registradores 4 e 3, guarda no 4
        selec_ula_action <= "01";
        ula_src_b <= "10";
        selec_reg_a <= "100";
        selec_reg_b <= "111";
        selec_reg_write <= "100";
        write_reg_en <= '1';
        wait for 2*time_period;
        -- Shift_right_2_b e Concatenates aMSB & bLSB dos registradores 1 e 2, guarda no 2
        selec_ula_action <= "10";
        ula_src_b <= "11";
        selec_reg_a <= "001";
        selec_reg_b <= "010";
        selec_reg_write <= "010"
        write_reg_en <= '1';
        wait for 2*time_period;
        -- Shift_right_2_b e CONCATENATE bMSB&aLSB dos registradores 6 e 7, guarda no 7
        selec_ula_action <= "11";
        ula_src_b <= "11";
        selec_reg_a <= "110";
        selec_reg_b <= "111";
        selec_reg_write <= "111";
        write_reg_en <= '1';
        wait for 2*time_period;
        write_reg_en <= '0';
        wait;
    end process;
end architecture rtl;