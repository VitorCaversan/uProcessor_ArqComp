library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_bank_testbench is
end entity reg_bank_testbench;

architecture rtl of reg_bank_testbench is
    component reg_bank is
        port
        (
            selec_reg_a     : IN unsigned (2 downto 0);
            selec_reg_b     : IN unsigned (2 downto 0);
            selec_reg_write : IN unsigned (2 downto 0);
            data_in         : IN unsigned (15 downto 0);
            write_en        : IN std_logic ;
            clk             : IN std_logic ;
            reset           : IN std_logic ;
            reg_data_a      : OUT unsigned (15 downto 0);
            reg_data_b      : OUT unsigned (15 downto 0)
        );
    end component;
    
    constant time_period: time := 100 fs;
    
    signal selec_reg_a, selec_reg_b, selec_reg_write: unsigned (2 downto 0);
    signal data_in, reg_data_a, reg_data_b: unsigned (15 downto 0);
    signal write_en, clk, reset, finished: std_logic;
    
begin
    uut: reg_bank port map(
        selec_reg_a     => selec_reg_a    , 
        selec_reg_b     => selec_reg_b    ,
        selec_reg_write => selec_reg_write,
        data_in         => data_in        ,
        write_en        => write_en       ,
        clk             => clk            ,
        reset           => reset          ,
        reg_data_a      => reg_data_a     ,
        reg_data_b      => reg_data_b
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
        selec_reg_a <= "000";
        selec_reg_b <= "100";
        selec_reg_write <= "000";
        data_in <= "0000000000000000";
        write_en <= '0';
        wait for 2*time_period;
        selec_reg_a <= "001";
        selec_reg_b <= "100";
        selec_reg_write <= "001";
        data_in <= "0000000000001111";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "001";
        selec_reg_b <= "001";
        selec_reg_write <= "000";
        data_in <= "0000000000000000";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "000";
        selec_reg_b <= "001";
        selec_reg_write <= "000";
        data_in <= "0000000000000000";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "111";
        selec_reg_b <= "101";
        selec_reg_write <= "111";
        data_in <= "0001000010100000";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "011";
        selec_reg_b <= "100";
        selec_reg_write <= "101";
        data_in <= "0000000001010101";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "000";
        selec_reg_b <= "101";
        selec_reg_write <= "100";
        data_in <= "1111000011011010";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "010";
        selec_reg_b <= "100";
        selec_reg_write <= "110";
        data_in <= "1111000011011010";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "110";
        selec_reg_b <= "100";
        selec_reg_write <= "011";
        data_in <= "1101101011010000";
        write_en <= '1';
        wait for 2*time_period;
        selec_reg_a <= "010";
        selec_reg_b <= "100";
        selec_reg_write <= "010";
        data_in <= "1101101011010001";
        write_en <= '1';
        wait for 2*time_period;
        write_en <= '0';
        wait;
    end process;
end architecture rtl;