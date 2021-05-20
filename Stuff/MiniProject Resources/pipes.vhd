LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;


ENTITY pipes IS
	PORT
		( clk 						: IN std_logic;
		  pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END pipes;

architecture behavior of pipes is

SIGNAL pipes_on					: std_logic;
SIGNAL wedge 					: std_logic_vector(9 DOWNTO 0);
SIGNAL height					: std_logic_vector(9 downto 0);  
SIGNAL pipes_y_pos, pipes_x_pos	: std_logic_vector(9 DOWNTO 0);

BEGIN           

wedge <= CONV_STD_LOGIC_VECTOR(30,10);
height <= CONV_STD_LOGIC_VECTOR(440,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
pipes_x_pos <= CONV_STD_LOGIC_VECTOR(550,10);
pipes_y_pos <= CONV_STD_LOGIC_VECTOR(40,10);


pipes_on <= '1' when ( ('0' & pipes_x_pos <= pixel_column + wedge) and ('0' & pixel_column <= pipes_x_pos + wedge) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipes_y_pos <= pixel_row + height) and ('0' & pixel_row <= pipes_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
-- Keeping background white and square in red
Red <=  '1';
-- Turn off Green and Blue when displaying square
Green <= not pipes_on;
Blue <=  not pipes_on;

END behavior;