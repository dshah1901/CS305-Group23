LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;



ENTITY collision_detector IS
	PORT
		( clk, vert_sync, reset, enable,start_screen, stat_screen, death_show,bird, heart, coin, text_on										: IN std_logic;
		  pipe1, pipe2																																						: IN std_logic;
		  gap1_br, gap2_br, gap1_lc, gap2_lc, bird_br																											: IN std_logic_vector(10 downto 0);
		  pix_row, pix_col																																				: in std_logic_vector (9 downto 0);
		  death, coin_reset, heart_reset, f_damage1, f_damage2, f_damage3, red,green,blue					 										: OUT std_logic;
		  score					 																																			: OUT std_logic_vector(6 downto 0);
		  score_ones, score_tens																																		: OUT std_logic_vector (3 downto 0));
		  		
END collision_detector;


architecture behaviour of collision_detector is
  signal f_death, f_health, f_coin, damage1, damage2, damage3, damage4										: std_logic;
  signal took_damage1,took_damage2																						: std_logic;
  signal health																												: std_logic_vector(1 downto 0);
  signal counter																												: std_logic_vector(4 downto 0);
  signal f_score					 																							: std_logic_vector(6 downto 0);
  signal f_score_ones, f_score_tens																						: std_logic_vector (3 downto 0);
  
 begin
    
	 f_damage1 <= damage2 and damage1;
	 f_damage2 <= damage3 and damage4;
	 f_damage3 <= '0';
	 death <= f_death;
	 score <= f_score;
	 score_ones <= f_score_ones;
	 score_tens <= f_score_tens;
	 heart_reset <= f_health;
	 coin_reset <=f_coin;
	
	
	
	
process(vert_sync) -- damage_detector
begin
if (rising_edge(vert_sync)) then
	if (reset <= '1') then
		f_score_tens <= "0000";
		f_score_ones <= "0000";
	end if;
	if( (gap1_lc <= CONV_STD_LOGIC_VECTOR(28,11)) and (CONV_STD_LOGIC_VECTOR(42,11) <= gap1_lc + CONV_STD_LOGIC_VECTOR(40,11) )) then --ga1_1c 
		damage1 <='1';
	else
		damage1 <='0';
	end if;
	if ( (gap1_br + CONV_STD_LOGIC_VECTOR(40,11) <= bird_br) or ( bird_br + CONV_STD_LOGIC_VECTOR(136,11) <= gap1_br)) then -- turns on when bird touches outside rows
		damage2 <= '1';
	else
		damage2 <= '0';
	end if;	
	
	if( (gap2_lc <= CONV_STD_LOGIC_VECTOR(28,11)) and (CONV_STD_LOGIC_VECTOR(42,11) <= gap2_lc + CONV_STD_LOGIC_VECTOR(40,11) )) then --ga1_1c 
		damage3 <='1';
	else
		damage3 <='0';
	end if;
	if ( (gap2_br + CONV_STD_LOGIC_VECTOR(40,11) <= bird_br) or ( bird_br + CONV_STD_LOGIC_VECTOR(136,11) <= gap2_br)) then -- turns on when bird touches outside rows
		damage4 <= '1';
	else
		damage4 <= '0';
	end if;
	f_death<= (damage2 and damage1) or(damage3 and damage4);
	--Score functionality
	
	if ( (gap2_lc = CONV_STD_LOGIC_VECTOR(0,11)) or (gap1_lc = CONV_STD_LOGIC_VECTOR(0,11))  ) then
		f_score <= f_score + conV_STD_LOGIC_VECTOR(1,7);
		f_score_ones <= f_score_ones + "0001";	
		if (f_score_ones > "1001") then
			f_score_tens <= f_score_tens + "0001";
			f_score_ones <= "0000";
		elsif ((f_score_tens > "1001") and (f_score_ones > "1001")) then
			f_score_tens <= "0000";
			f_score_ones <= "0000";
		end if;
		end if;
end if;
end process;
	 
	 

		
		
		
	 

	 

process(clk)
begin
if rising_edge(clk) then
	if (start_screen = '1') then
		if (text_on= '1') then
		red <= '0';
		green <= '0';
		blue <= '0';
		else
		red <= '1';
		green <= '1';
		blue <= '1';
		end if;
	elsif (stat_screen = '1') then
		IF (text_on= '1') then
		red <= '0';
		green <= '0';
		blue <= '0';
		elsif (bird = '0') then
		red<= '0';
		green<= '0';
		blue<= '1';
		elsif (heart='1') THEN
		red <= '1';
		green <= '0';
		blue <= '0';
		ELSIF (coin='1') then
		red <= '1';
		green <= '1';
		blue <= '0';
		elsif ( pipe1 = '1' or pipe2 = '1') then
		red <= '0';
		blue <= '0';
		green <= '1';
		else
		red <= '1';
		green <= '1';
		blue <= '1';
		end if;
	elsif (death_show = '1') then
		IF (text_on= '1') then
		red <= '0';
		green <= '0';
		blue <= '0';
		else
		red <= '1';
		green <= '1';
		blue <= '1';
		end if;
		
	end if;
end if;
end process;



end behaviour;