LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;



ENTITY pipes IS
	PORT
		( clk, vert_sync						: IN std_logic;
		  pixel_row, pixel_column			: IN std_logic_vector(9 DOWNTO 0);
		  pipe_on					 			: OUT std_logic);		
END pipes;

architecture behavior of pipes is

SIGNAL pipes_on				: std_logic;
SIGNAL wedge 					: std_logic_vector(9 DOWNTO 0);
SIGNAL height					: std_logic_vector(9 downto 0);  
SIGNAL pipes_y_pos, pipes_x_pos	: std_logic_vector(9 DOWNTO 0);
SIGNAL pipe_x_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

wedge <= CONV_STD_LOGIC_VECTOR(30,10);
height <= CONV_STD_LOGIC_VECTOR(440,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball
pipes_y_pos <= CONV_STD_LOGIC_VECTOR(40,10);


pipes_on <= '1' when ( ('0' & pipes_x_pos <= pixel_column+ wedge + wedge) and ('0' & pixel_column <= pipes_x_pos ) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipes_y_pos <= pixel_row + height) and ('0' & pixel_row <= pipes_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';


-- Colours for pixel data on video signal
-- Keeping background white and square in red
pipe_on <=  not(pipes_on);
-- Turn off Green and Blue when displaying square


Move_pipe: process (vert_sync) 
 	
begin
	-- Move pipe once every vertical sync
	if (rising_edge(vert_sync)) then
		pipe_x_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		
		-- Bounce off top or bottom of the screen
		if (('0' & pipes_x_pos <= CONV_STD_LOGIC_VECTOR(0,11))) then
			pipes_x_pos <= CONV_STD_LOGIC_VECTOR(700,10);
		else 
			pipes_x_pos <= pipes_x_pos - pipe_x_motion;
		end if;
		
		-- Compute next pipe Y position
		
	end if;
end process Move_pipe;

END behavior;