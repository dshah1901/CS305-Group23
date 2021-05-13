LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY boo_pipe IS
	PORT
		( pb1, pb2, clk, vert_sync	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END boo_pipe;

architecture behavior of boo_pipe is

SIGNAL ball_on					: std_logic;
SIGNAL wedge 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL height					: std_logic_vector(9 DOWNTO 0);
SiGNAL ball_x_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL ball_x_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

wedge <= CONV_STD_LOGIC_VECTOR(30,10);
height <= CONV_STD_LOGIC_VECTOR(150,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
ball_y_pos <= CONV_STD_LOGIC_VECTOR(40,10);

ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + wedge) and ('0' & pixel_column <= '0' & ball_x_pos + wedge) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + height) and ('0' & pixel_row <= ball_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
-- Changing the background and ball colour by pushbuttons
Red <=  not ball_on;
Green <= not ball_on;
Blue <=  not ball_on;


Move_Ball: process (vert_sync)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Bounce off top or bottom of the screen
		if ( ('0' & ball_x_pos >= CONV_STD_LOGIC_VECTOR(629,10) - wedge) ) then
			ball_x_motion <= - CONV_STD_LOGIC_VECTOR(2,10);
		elsif (ball_x_pos <= wedge) then 
			ball_x_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		end if;
		-- Compute next ball Y position
		ball_x_pos <= ball_x_pos + ball_x_motion;
	end if;
end process Move_Ball;

END behavior;