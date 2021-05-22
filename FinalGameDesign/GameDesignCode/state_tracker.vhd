LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;



Entity state_tracker is 
	port(clk, death, left_click, right_click 	: in std_logic;
			score 										: in std_logic_vector(5 downto 0);
			enable, reset 								: out std_logic ;
			difficulty 									: out std_logic_vector(2 downto 0));

end entity state_tracker;

architecture beh of state_tracker is
type state_type is (start, training, level1, level2, level3, death_screen);
signal state: state_type := start;
signal next_state: state_type;

begin

process (clk) -- state changes
begin
	if (rising_edge(clk)) then
		case state is 
		when start =>
			if (left_click = '1') then
				next_state <= training; 
			elsif (right_click = '1') then
				next_state <= level1; 
			end if;
		when training =>
			if (death = '1') then 
				next_state <= start;
			end if;
		when level1 =>
			if (death = '1') then 
				next_state <= death_screen;
			elsif (score >= 10) then
				next_state <= level2;
			end if;
		when level2 =>
			if (death = '1') then 
				next_state <= death_screen;
			elsif (score >= 10) then
				next_state <= level3;
			end if;
		when level3 =>
			if (death = '1') then
				next_state <= death_screen;
			end if ;
		when others =>
			if (left_click = '1' or right_click = '1') then
				next_state <= start ;
			end if;
  		end case;
	end if;
end process;

process (state) --state outputs
begin
	case state is 
		when start =>
			enable <= '0';
			reset <= '1';
			difficulty <= "00";
		when training =>
			enable <= '1';
			reset <= '0';
			difficulty <= "00";
		when level1 =>
			enable <= '1';
			reset <= '0';
			difficulty <= "01";
		when level2 =>
			enable <= '1';
			reset <= '0';
			difficulty <= "10";
		when level3 =>
			enable <= '1';
			reset <= '0';
			difficulty <= "11";
		when others =>
			enable <= '1';
			reset <= '0';
			difficulty <= "00";
  		end case;
end process;

end beh;