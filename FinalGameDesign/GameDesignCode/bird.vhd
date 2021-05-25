LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bird IS
	PORT
		( left_button, clk, vert_sync, reset						: IN std_logic;
				pixel_row, pixel_column									: IN std_logic_vector(9 DOWNTO 0);
				difficulty 													: in std_logic_vector(1 downto 0);
				o_bird_on 													: OUT std_logic);
END bird;

architecture behavior of bird is

SIGNAL bird_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL bird_y_pos	         		: std_logic_vector(9 DOWNTO 0) ;
SiGNAL bird_x_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL bird_y_motion			: std_logic_vector(9 DOWNTO 0);

BEGIN           

size <= CONV_STD_LOGIC_VECTOR(8,10);
-- bird_x_pos and bird_y_pos show the (x,y) for the centre of bird
bird_x_pos <= CONV_STD_LOGIC_VECTOR(100,11);

bird_on <= '1' when ( ('0' & bird_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & bird_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & bird_y_pos <= pixel_row + size) and ('0' & pixel_row <= bird_y_pos + size))  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
o_bird_on <= not bird_on;

-- Colours for pixel data on video signal
-- Changing the background and bird colour by pushbuttons
Move_bird: process (vert_sync)  	
begin
	-- Move bird once every vertical sync
	if (rising_edge(vert_sync)) then			
		
			if (bird_y_pos <= size) then
				bird_y_motion <= CONV_STD_LOGIC_VECTOR(2,10)+ ("00000000" & difficulty);
			elsif (left_button = '1') then
				bird_y_motion <= -(CONV_STD_LOGIC_VECTOR(2,10) + ("00000000" & difficulty)) ;
			elsif('0' & bird_y_pos >= conv_std_logic_vector(479,10) - size) then 
				bird_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
			else 
				bird_y_motion <= CONV_STD_LOGIC_VECTOR(2,10) ;
			end if;
			bird_y_pos <= bird_y_pos + bird_y_motion;
		
			
			if (reset='1') then
				bird_y_pos <= CONV_STD_LOGIC_VECTOR(200,10);
			end if;
			
		-- Compute next bird Y position
		
		
	end if;
end process Move_bird;

END behavior;

