LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY VGA_control IS
	PORT
		(enable,reset, clk, ball_on									: IN std_logic;
			pipe1,pipe2,pipe3,pipe4,pipe5 							: IN std_logic;
			coin_on, heart_on 											: in std_logic;
			pix_row, pix_col												: in std_logic_vector (9 downto 0);
			red, greem, blue 												: out std_logic_vector (3 downto 0);
			score 															: out std_logic_vector (6 downto 0);
			death 															: OUT std_logic);
END VGA_control;


architecture beh of VGA_control is
signal f_score : std_logic_vector (6 downto 0);
signal health	: std_logic_vector (1 downto 0);
signal f_death : std_logic;
begin


death <= f_death
score <= f_score

process (pix_row,pix_col)
begin
	if (reset = '1') then
		f_score <= "0000000";
		health <= "11";
		f_death <= '0';
	--HEALTH TRACKER
	elsif (enable = '1') then
		if (ball_on and (pipe1 or pipe2 or pipe3 or pipe4 or pipe5)) then
			if ( health = "01") then
			f_death <= '1';
			else
			health <= health - CONV_STD_LOGIC_VECTOR(1,2);
			end if;
		elsif(ball_on and heart_on) then
			if ( "11" >  health) then
				health <= health + CONV_STD_LOGIC_VECTOR(1,2);
			end if;
		end if;
	
	
	-- SCORE TRACKER
		if (ball_on and coin_on) then
			score <= f_score + CONV_STD_LOGIC_VECTOR(2,7);
		end if;
		if 
	
	end if 
end process

end beh;