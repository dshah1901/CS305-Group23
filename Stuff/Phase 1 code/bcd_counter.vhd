library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
 
 entity bcd_counter is
  port(clk,enable,init,direction: in std_logic;  
       counter:out std_logic_vector(3 downto 0));
end entity bcd_counter;

architecture beh of bcd_counter is
  signal x : std_logic_vector(3 downto 0);
begin
  process(clk)
     variable d1 : integer range 0 to 9 := 0;
  begin
    if (clk'event and clk = '1' and enable = '1') then 
      if (init = '1') then -- only when init 1 it initalises
        if(direction = '1') then
          d1:= 0;
        elsif (direction = '0') then
          d1 := 9; 
        end if;
      elsif (direction = '1') then
        if(d1 = 9) then
          d1 := 0;    
        else 
          d1 := d1 + 1; -- add condiiton if it is at 9 
        end if; 
      elsif(direction = '0') then
        if(d1 = 0) then
          d1 := 9; 
        else
          d1 := d1 - 1; 
        end if; 
      end if; 
    end if; 
    case d1 is
      when 0   =>    x <= "0000";  
      when 1   =>    x <= "0001";  
      when 2   =>    x <= "0010";  
      when 3   =>    x <= "0011";
      when 4   =>    x <= "0100";  
      when 5   =>    x <= "0101";  
      when 6   =>    x <= "0110";  
      when 7   =>    x <= "0111"; 
      when 8   =>    x <= "1000"; 
      when 9   =>    x <= "1001";  
    end case;
    counter <= x; 
  end process;
end architecture beh; 
  