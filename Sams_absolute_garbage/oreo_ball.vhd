LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY oreo_ball IS
	PORT
		( left_button	: IN std_logic;
          pixel_row, pixel_column	: in std_logic_vector(9 downto 0);
		  red, green, blue 			: out std_logic_vector (4 downto 0));		
END oreo_ball;