LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;



ENTITY collision_detector IS
	PORT
		( clk, vert_sync, reset, enable,start_screen, stat_screen, death_show,bird, heart, coin, text_on										: IN std_logic;
		  pipe1, pipe2																																						: IN std_logic;
		  gap1_br, gap2_br, gap1_lc, gap2_lc, bird_br																											: IN std_logic_vector(10 downto 0);
		  death, coin_reset, heart_reset, f_damage1, f_damage2, f_damage3, red,green,blue					 										: OUT std_logic;
		  pix_row, pix_col																																				: in std_logic_vector (9 downto 0);
		  score					 																																			: OUT std_logic_vector(6 downto 0));		
END collision_detector;


architecture behaviour of collision_detector is
  signal f_death, f_health, f_coin, damage1, damage2, damage3, damage4										: std_logic;
  signal took_damage1,took_damage2																						: std_logic;
  signal score_tracker, f_score_tracker																				: std_logic_vector(6 downto 0);
  signal health																												: std_logic_vector(1 downto 0);
  signal counter																												: std_logic_vector(4 downto 0);
  
 begin
    
	 f_damage1 <= damage2 and damage1;
	 f_damage2 <= damage3 and damage4;
	 f_damage3 <= '0';
	 death <= f_death;
	 score <= score_tracker;
	 heart_reset <= f_health;
	 coin_reset <=f_coin;
	
	
	
	
process(vert_sync) -- damage_detector
begin
if (rising_edge(vert_sync)) then
	if( (gap1_lc <= CONV_STD_LOGIC_VECTOR(58,11)) and (CONV_STD_LOGIC_VECTOR(42,11) <= gap1_lc + CONV_STD_LOGIC_VECTOR(60,11) )) then --ga1_1c 
		damage1 <='1';
	else
		damage1 <='0';
	end if;
	if ( (gap1_br + CONV_STD_LOGIC_VECTOR(80,11) <= bird_br) or ( bird_br + CONV_STD_LOGIC_VECTOR(176,11) <= gap1_br)) then -- turns on when bird touches outside rows
		damage2 <= '1';
	else
		damage2 <= '0';
	end if;	
	
	if( (gap2_lc <= CONV_STD_LOGIC_VECTOR(58,11)) and (CONV_STD_LOGIC_VECTOR(42,11) <= gap2_lc + CONV_STD_LOGIC_VECTOR(60,11) )) then --ga1_1c 
		damage3 <='1';
	else
		damage3 <='0';
	end if;
	if ( (gap2_br + CONV_STD_LOGIC_VECTOR(80,11) <= bird_br) or ( bird_br + CONV_STD_LOGIC_VECTOR(176,11) <= gap2_br)) then -- turns on when bird touches outside rows
		damage4 <= '1';
	else
		damage4 <= '0';
	end if;
	took_damage1<= damage2 and damage1;
	took_damage2 <= damage3 and damage4;
end if;
end process;
	 
	 
process (took_damage1,took_damage2) -- take damage 
begin

if (falling_edge (took_damage1)) then
	health <= health - CONV_STD_LOGIC_VECTOR(1,2); 
end if;

if (falling_edge (took_damage2)) then
	health <= health - CONV_STD_LOGIC_VECTOR(1,2);
end if;

if (health <= "00") then
	f_death <= '1';
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
		end if;
	end if;
end if;
end process;



end behaviour;