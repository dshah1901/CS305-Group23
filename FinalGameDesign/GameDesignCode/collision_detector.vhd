LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;



ENTITY collision_detector IS
	PORT
		( clk, vert_sync, reset, enable															: IN std_logic;
		  bird, pipe1, pipe2, pipe3, heart, coin 	: IN std_logic;
		  death, coin_reset, heart_reset, f_damage1, f_damage2, f_damage3					 									: OUT std_logic;
		  pix_row, pix_col																			: in std_logic_vector (9 downto 0);
		  score					 																		: OUT std_logic_vector(6 downto 0));		
END collision_detector;


architecture behaviour of collision_detector is
  signal f_death, f_health, f_coin, damage1, damage2, damage3														: std_logic;
  signal score_tracker, f_score_tracker																				: std_logic_vector(6 downto 0);
  signal health																												: std_logic_vector(1 downto 0);
  
 begin
    
	 f_damage1 <= damage1;
	 f_damage2 <= damage2;
	 f_damage3 <= damage3;
	 death <= f_death;
	 score <= score_tracker;
	 heart_reset <= f_health;
	 coin_reset <=f_coin;
	 
	 
process (vert_sync, pix_row, pix_col)
begin
	if rising_edge(vert_sync) then
	if (reset = '1') then
		health <= "11";
		f_death <= '0';
		damage1 <= '0';
		score_tracker <= "0000000";
	--HEALTH TRACKER
	elsif (enable = '1') then
	
		-- decrease health
		if (bird = '1'  and pipe1 = '0' and damage1 = '0') then
			damage1 <= '1';
			damage2 <= '0';
			damage3 <= '0';
			if ( health = "00") then
				f_death <= '1';
			else
				health <= health - CONV_STD_LOGIC_VECTOR(1,2);
				
			end if;
		elsif (bird = '1'  and  pipe2 = '0'and damage2 = '0' ) then
			damage1 <= '0';
			damage2 <= '1';
			damage3 <= '0';
			if ( health = "00") then
				f_death <= '1';
			else
				health <= health - CONV_STD_LOGIC_VECTOR(1,2);
			end if;
			
		elsif (bird = '1'  and  pipe3 = '0' and damage3 = '0' ) then
			damage1 <= '0';
			damage2 <= '0';
			damage3 <= '1';
			if ( health = "00") then
				f_death <= '1';
			else
				health <= health - CONV_STD_LOGIC_VECTOR(1,2);
			end if;
			
			
			
			
		-- increase health	
		elsif(bird = '1' and heart = '1') then
			if ( "11" >  health) then
				health <= health + CONV_STD_LOGIC_VECTOR(1,2);
				f_health <= '0';
			end if;
		else
			f_health <= '0';
		end if;
		
		end if;
	
	-- SCORE TRACKER
	
		--increases score with coin
--		if (bird = '1' and coin = '1') then
--			score_tracker <= score_tracker + CONV_STD_LOGIC_VECTOR(2,7);
--			f_coin <= '1';
--		end if;
--		
--		
--		--increases score by pipe
--		if (pix_col = "0000000000" and pix_row = "0000000000" and (pipe1 = '1' or pipe2 = '1' or pipe3 = '1')) then
--			f_score_tracker <= f_score_tracker + CONV_STD_LOGIC_VECTOR(1,6);
--			if (f_score_tracker = "0111100") then
--				f_score_tracker <= "0000000";
--				score_tracker <= score_tracker + CONV_STD_LOGIC_VECTOR(1,7);
--			end if;
--		end if;
	end if;
end process;


end behaviour;