LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;



ENTITY ball IS
	PORT
		( clk 						: IN std_logic;
		  pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END ball;

architecture behavior of ball is

SIGNAL ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);
SIGNAL height					: std_logic_vector(9 downto 0);
SIGNAL ball_y_pos       	: std_logic_vector(9 DOWNTO 0);
SIGNAL ball_x_motion			: std_logic_vector(9 DOWNTO 0);
signal ball_x_pos	: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(600,10) ;

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(40,10);
height <= CONV_STD_LOGIC_VECTOR(480,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
--ball_x_pos <= CONV_STD_LOGIC_VECTOR(0,10);
ball_y_pos <= CONV_STD_LOGIC_VECTOR(0,10);


ball_on <= '1' when ( ('0' & ball_x_pos <= pixel_column + size) and ('0' & pixel_column <= ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + height) and ('0' & pixel_row <= ball_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
-- Keeping background white and square in red
Red <=  '1';
-- Turn off Green and Blue when displaying square
Green <= not ball_on;
Blue <=  not ball_on;


process (clk)
begin
--('0' & ball_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size)
	if( CONV_STD_LOGIC_VECTOR(0,10)>= ball_x_pos ) then
		ball_x_pos <= CONV_STD_LOGIC_VECTOR(680,10);
	end if;

	ball_x_pos <= ball_x_pos - CONV_STD_LOGIC_VECTOR(2,10);
end process;

END behavior;

