LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY VGA_control IS
	PORT
		(enable,reset, ball_on, pipe1,pipe2,pipe3,pipe4,pipe5	: IN std_logic;
			coin_on, heart_on : in std_logic;
			red, greem, blue : out std_logic_vector (3 downto 0);
			score 			: out std_logic_vector (6 downto 0);
			death 			: OUT std_logic));
END VGA_control;


architecture beh of VGA_control is
signal f_score : std_logic_vector (6 downto 0);

begin




end beh;