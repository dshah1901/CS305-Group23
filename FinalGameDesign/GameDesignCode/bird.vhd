LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bird IS
	PORT
		( pb1, pb2, clk, vert_sync, left_button	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END bird;

architecture behavior of bird is

SIGNAL bird_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL bird_y_pos				: std_logic_vector(9 DOWNTO 0);
SiGNAL bird_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL bird_y_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- bird_x_pos and bird_y_pos show the (x,y) for the centre of bird
bird_x_pos <= CONV_STD_LOGIC_VECTOR(590,11);

bird_on <= '1' when ( ('0' & bird_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & bird_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & bird_y_pos <= pixel_row + size) and ('0' & pixel_row <= bird_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
-- Changing the background and bird colour by pushbuttons
Red <=  pb1;
Green <= (not left_button) and (not bird_on);
Blue <=  not bird_on;


Move_bird: process (vert_sync,pb1,pb2,left_button)  	
begin
	-- Move bird once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Bounce off top or bottom of the screen
		
		if (pb1 = '1') then
			if ( ('0' & bird_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) or left_button = '1') then
				bird_y_motion <= - CONV_STD_LOGIC_VECTOR(2,10);
			elsif ((bird_y_pos <= size)or pb2 = '1') then 
				bird_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
			end if;
		elsif(pb1='0') then
			bird_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
		end if;
		
		
		
		
--		if ( ('0' & bird_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) ) then
--			bird_y_motion <= - CONV_STD_LOGIC_VECTOR(2,10);
--		elsif (bird_y_pos <= size) then 
--			bird_y_motion <= CONV_STD_LOGIC_VECTOR(2,10);
--		end if;
		
		
		-- Compute next bird Y position
		bird_y_pos <= bird_y_pos + bird_y_motion;
	end if;
end process Move_bird;

END behavior;

