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
  signal f_death, f_health, f_coin, damage1, damage2, damage3													: std_logic;
  signal took_damage1,took_damage2,took_damage3																		: std_logic;
  signal score_tracker, f_score_tracker																				: std_logic_vector(6 downto 0);
  signal health																												: std_logic_vector(1 downto 0);
  signal counter																												: std_logic_vector(4 downto 0);
  
 begin
    
	 f_damage1 <= damage1;
	 f_damage2 <= damage2;
	 f_damage3 <= damage2;
	 death <= f_death;
	 score <= score_tracker;
	 heart_reset <= f_health;
	 coin_reset <=f_coin;
	
	
	
	
process(clk)
begin
if (rising_edge(clk)) then
	if( (gap1_lc < "00000101010") or ("00000101010" < gap1_lc + "00001001110" )) then
		damage2 <='1';
		if ( (gap1_br <= bird_br) or ( bird_br<= gap1_br-"00001010000")) then
			damage1 <= '1';
		else
			damage1 <= '0';
		end if;
	else
		damage2 <='0';
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
		end if;
	end if;
end if;
end process;



end behaviour;