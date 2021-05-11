--Seven_seg
library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

--VHDL  code for BCD to 7-segment

entity seven_seg is
  port (digit: in std_logic_vector(3 downto 0);
    LED_out: out std_logic_vector(6 downto 0));
end entity seven_seg;

architecture arc of seven_seg is
  begin
    process (digit)
      begin
          case digit is
            when "0000" => LED_out <= "1000000"; --0
				when "0001" => LED_out <= "1111001"; --1
				when "0010" => LED_out <= "0100100"; --2
            when "0011" => LED_out <= "0110000"; --3
				when "0100" => LED_out <= "0011001"; --4
            when "0101" => LED_out <= "0010010"; --5
				when "0110" => LED_out <= "0000010"; --6		
            when "0111" => LED_out <= "1111000"; --7
            when "1000" => LED_out <= "0000000"; --8
            when "1001" => LED_out <= "0010000"; --9
            when others => LED_out <= "1111111";
          end case;
      end process;
 end architecture arc;