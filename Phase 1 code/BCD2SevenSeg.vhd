library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

--VHDL  code for BCD to 7-segment
--Turn off the Display when all_off is '1'

entity BCD2SevenSeg is
  port (digit: in std_logic_vector(3 downto 0);
    all_off: in std_logic;
    LED_out: out std_logic_vector(7 downto 0));
end entity BCD2SevenSeg;

architecture arc of BCD2SevenSeg is
  begin
    process (digit, all_off)
      begin
        if (all_off = '1') then
          LED_out <= "11111111";
        else
          case digit is
            when "0000" => LED_out <= "00000011"; --0
            when "0001" => LED_out <= "10011111"; --1
            when "0010" => LED_out <= "00100101"; --2
            when "0011" => LED_out <= "00001101"; --3
            when "0100" => LED_out <= "10011001"; --4
            when "0101" => LED_out <= "01001001"; --5  
            when "0110" => LED_out <= "01000001"; --6
            when "0111" => LED_out <= "00011111"; --7
            when "1000" => LED_out <= "00000001"; --8
            when "1001" => LED_out <= "00001001"; --9
            when others => LED_out <= "11111111";
          end case;
        end if;
      end process;
 end architecture arc;
  
    
    