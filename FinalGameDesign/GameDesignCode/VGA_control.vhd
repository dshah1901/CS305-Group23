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

process(vert_sync)
if rising_edge(vert_sync) then
if (pipe1 or pipe2 or pipe3 and not(ball_on or heart_on or coin_on)) then
red<= '0';
green<= '1';
blue<= '0';
elsif (BALl_on AND NOT(pipe1 or pipe2 or pipe3)) THEN
red <= '0';
green <= '0';
blue <= '1';
ELSIF (heart_on and not (pipe1 or pipe2 or pipe3 or ball_on or coin_on)) then
red <= '1';
green <= '0';
blue <= '0';
elsIF (coin_on and not(pipe1 or pipe2 or pipe3 or ball_on or heart_on)) then
red <= '1';
green <= '1';
blue <= '0';
elsif (text_on and not (pipe1 or pipe2 or pipe3 or ball_on or heart_on or coin_on)) then
red <= '0';
blue <= '0';
green <= '0';
elsif not(text_on or pipe1 or pipe2 or pipe3 or ball_on or heart_on or coin_on) then
red <= '1';
green <= '1';
blue <= '1';
end if;
end if;
end process;
end beh;