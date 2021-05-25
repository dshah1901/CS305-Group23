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
begin
if rising_edge(vert_sync) then
if (text_on= '0' or pipe1 = '1' or pipe2 = '1' or pipe3 = '1' or ball_on='0' or heart_on='0' or coin_on='0') then
red<= '0';
green<= '1';
blue<= '0';
elsif (text_on= '0' or pipe1 = '0' or pipe2 = '0' or pipe3 = '0' or ball_on='1' or heart_on='0' or coin_on='0') THEN
red <= '0';
green <= '0';
blue <= '1';
ELSIF (text_on= '0' or pipe1 = '0' or pipe2 = '0' or pipe3 = '0' or ball_on='0' or heart_on='1' or coin_on='0') then
red <= '1';
green <= '0';
blue <= '0';
elsIF (text_on= '0' or pipe1 = '0' or pipe2 = '0' or pipe3 = '0' or ball_on='0' or heart_on='0' or coin_on='1') then
red <= '1';
green <= '1';
blue <= '0';
elsif (text_on= '1' or pipe1 = '0' or pipe2 = '0' or pipe3 = '0' or ball_on='0' or heart_on='0' or coin_on='0') then
red <= '0';
blue <= '0';
green <= '0';
elsif ( text_on = '0' or pipe1 = '0' or pipe2 = '0' or pipe3 = '0' or ball_on='0' or heart_on='0' or coin_on='0') then
red <= '1';
green <= '1';
blue <= '1';
end if;
end if;
end process;
end beh;