library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ula_testbench is
end entity;

architecture rtl of ula_testbench is
    component ula is
        port
        (
            a          : IN unsigned (15 downto 0);
            b          : IN unsigned (15 downto 0);
            selec      : IN unsigned (1 downto 0);
            output     : OUT unsigned (15 downto 0);
            equal      : OUT std_logic ;
            greater_a  : OUT std_logic ;
            a_negative : OUT std_logic ;
            b_negative : OUT std_logic
        );
    end component;

    signal a, b, output: unsigned (15 downto 0);
    signal selec: unsigned(1 downto 0);
    signal equal, greater_a, a_negative, b_negative: std_logic;

begin
   uut: ula port map(
      a => a,
      b => b,
      selec => selec,
      output => output,
      equal => equal,
      greater_a => greater_a,
      a_negative => a_negative,
      b_negative => b_negative
   );

   process
   begin
      -- SOMA SUBTRAI -----------------------------
      a <= "0000000000000000";
      b <= "0000000000000000";
      selec <= "00";
      wait for 50 ns;
      a <= "0000000000000000";
      b <= "0000000000000000";
      selec <= "01";
      wait for 50 ns;
      -- a e b positivos soma
      a <= "0000000001000101";
      b <= "0000000110100100";
      selec <= "00";
      wait for 50 ns;
      -- a e b positivos subtrai
      a <= "0000000001000101";
      b <= "0000000110100100";
      selec <= "01";
      wait for 50 ns;
      -- a negativo b positivo soma
      a <= "1000000001000101";
      b <= "0000000110100100";
      selec <= "00";
      wait for 50 ns;
      -- a negativo b positivo subtrai
      a <= "1000000001000101";
      b <= "0000000110100100";
      selec <= "01";
      wait for 50 ns;
      -- a positivo b negativo soma
      a <= "0000000001000101";
      b <= "1000000110100100";
      selec <= "00";
      wait for 50 ns;
      -- a positivo b negativo subtrai
      a <= "0000000001000101";
      b <= "1000000110100100";
      selec <= "01";
      wait for 50 ns;
      -- a e b negativos soma
      a <= "1010010001100101";
      b <= "1100100110100100";
      selec <= "00";
      wait for 50 ns;
      -- a e b negativos subtrai
      a <= "1010010001100101";
      b <= "1100100110100100";
      selec <= "01";
      -- CONCATENATE aMSB&bLSB ------------------------------------
      wait for 50 ns;
      a <= "1111111111111111";
      b <= "0000000000000000";
      selec <= "10";
      wait for 50 ns;
      a <= "0000000000000000";
      b <= "1111111111111111";
      selec <= "10";
      -- CONCATENATE bMSB&aLSB--------------------------------
      wait for 50 ns;
      a <= "1111111111111111";
      b <= "0000000000000000";
      selec <= "11";
      wait for 50 ns;
      a <= "0000000000000000";
      b <= "1111111111111111";
      selec <= "11";
      wait for 50 ns;
      wait;
   end process;
end architecture rtl;