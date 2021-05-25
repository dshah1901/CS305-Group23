LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY VGA_control IS
	PORT
		(clk, ball_on, text_on ,vert_sync								: IN std_logic;
			pipe1, pipe2, pipe3				 							: IN std_logic;
			coin_on, heart_on 											: in std_logic;
			pix_row, pix_col												: in std_logic_vector (9 downto 0);
			red, green, blue 												: out std_logic);
END VGA_control;


architecture beh of VGA_control is
begin

red <= (ball_on AND HEArt_on);
green <= (ball_on AND COIN_ON);
blue <= (pipe3 AND PIPE1 AND PIPE2 and ball_on);



end beh;