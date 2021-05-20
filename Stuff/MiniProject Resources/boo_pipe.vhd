LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY boo_pipe IS
	PORT
		( pb1, pb2, clk, vert_sync,in_ball_on	: IN std_logic;
          pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  red, green, blue 			: OUT std_logic);		
END boo_pipe;

architecture behavior of boo_pipe is

SIGNAL pipe_on,pipe_top,pipe_bottom					: std_logic;
SIGNAL wedge 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL t_pipe_y_pos,b_pipe_y_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL height					: std_logic_vector(9 DOWNTO 0);
SiGNAL pipe_x_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL pipe_x_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

wedge <= CONV_STD_LOGIC_VECTOR(30,10);
height <= CONV_STD_LOGIC_VECTOR(100,10);

-- pipe_x_pos and pipe_y_pos show the (x,y) for the centre of pipe
t_pipe_y_pos <= CONV_STD_LOGIC_VECTOR(100,10);
--b_pipe_y_pos <= CONV_STD_LOGIC_VECTOR(380,10);
b_pipe_y_pos <= CONV_STD_LOGIC_VECTOR(379,10);

pipe_top <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + wedge) and ('0' & pixel_column <= '0' & pipe_x_pos + wedge) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & t_pipe_y_pos <= pixel_row + height) and ('0' & pixel_row <= t_pipe_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';

pipe_bottom <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + wedge) and ('0' & pixel_column <= '0' & pipe_x_pos + wedge) 	-- x_pos - size <= pixel_column <= x_pos + size
				and ('0' & b_pipe_y_pos <= pixel_row + height) and ('0' & pixel_row <= b_pipe_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
		'0';

--Trying something here			
--pipe_bottom <= '1' when ( ('0' & pipe_x_pos <= '0' & pixel_column + wedge) and ('0' & pixel_column <= '0' & pipe_x_pos + wedge) 	-- x_pos - size <= pixel_column <= x_pos + size
				--and ('0' & b_pipe_y_pos <= pixel_row + height) and ('0' & pixel_row <= b_pipe_y_pos + height) )	-- y_pos - size <= pixel_row <= y_pos + size
		--'0';		
			
			
			
pipe_on <= pipe_top or pipe_bottom;

-- Colours for pixel data on video signal
-- Changing the background and pipe colour by pushbuttons
Red <=  in_ball_on;
Green <=  pipe_top;
Blue <=  pipe_bottom;


Move_pipe: process (vert_sync)  	
begin
	-- Move pipe once every vertical sync
	if (rising_edge(vert_sync)) then			
		-- Bounce off top or bottom of the screen
		if ( ('0' & pipe_x_pos >= CONV_STD_LOGIC_VECTOR(629,10) - wedge) ) then
			pipe_x_motion <= - CONV_STD_LOGIC_VECTOR(2,10);
		elsif (pipe_x_pos <= wedge+wedge) then 
			pipe_x_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		end if;
		-- Compute next pipe Y position
		pipe_x_pos <= pipe_x_pos + pipe_x_motion;
	end if;
end process Move_pipe;

END behavior;