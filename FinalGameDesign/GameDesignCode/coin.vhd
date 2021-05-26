LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

Entity coin is
port (vert_sync, clk, reset 				:in std_logic;
		  pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  coin_on 			: OUT std_logic);
end coin;

architecture behavior of coin is

component LFSR_generator
port (clk, reset		: in std_logic;
seed						: in std_logic_vector(3 downto 0);
lfsr 						: out std_logic_vector(3 downto 0));
end component LFSR_generator;

SIGNAL coin_y_pos, coin_x_pos					: std_logic_vector(9 DOWNTO 0);
SIGNAL radius										: std_logic_vector(9 DOWNTO 0);
SIGNAL coin_x_motion								: std_logic_vector(9 DOWNTO 0);
Signal send											: std_logic_vector(3 downto 0) := "0001";
signal lfsr1 										: std_logic_vector(3 downto 0);
signal count										: std_logic_vector(9 downto 0);
signal iscoin										: std_logic;

BEGIN           

radius <= CONV_STD_LOGIC_VECTOR(10, 10);

random: LFSR_generator
port map (Clk => clk, reset => '1', seed => send, lfsr => lfsr1);
-- pipe_x_pos and pipe_y_pos show the (x,y) for the centre of pipe

coin_on <= '1' when ( ('0' & coin_x_pos <= pixel_column + radius) and ('0' & pixel_column <= coin_x_pos + radius) 	-- x_pos - radius <= pixel_column <= x_pos + radius
					and ('0' & coin_y_pos <= pixel_row + radius) and ('0' & pixel_row <= coin_y_pos + radius) and (iscoin='1'))  else	-- y_pos - radius <= pixel_row <= y_pos + radius
			'0';					
			
Move_coin: process (vert_sync) 
 	
begin
	-- Move pipe once every vertical sync
	if (rising_edge(vert_sync)) then
		coin_x_motion <= CONV_STD_LOGIC_VECTOR(2,10);
		
		if reset = '1' then
				coin_x_pos <= CONV_STD_LOGIC_VECTOR(850,10);
				count <= "0000000000";
		-- Bounce off top or bottom of the scree
		elsif (('0' & coin_x_pos <= CONV_STD_LOGIC_VECTOR(0,11))) then 
			if (count < CONV_STD_LOGIC_VECTOR(300,9)) then
				iscoin<= '0';
				count <= count + "000000001";
			else
					case lfsr1 is
						when "0001" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(30,10);
						when "0010" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(60,10);
						when "0011" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(90,10);
						when "0100" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(120,10);
						when "0101" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(150,10);
						when "0110" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(180,10);
						when "0111" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(210,10);
						when "1000" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(240,10);
						when "1001" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(270,10);
						when "1010" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(300,10);
						when "1011" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(330,10);
						when "1100" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(360,10);
						when "1101" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(420,10);
						when "1110" => coin_y_pos <= CONV_STD_LOGIC_VECTOR(450,10);
						when others => coin_y_pos <= CONV_STD_LOGIC_VECTOR(460,10);
					end case;
					
					if (send >= "1111") then
						send <= "0001";
					else
						send <= send + "0001";
					end if;
					iscoin <= '1';
					coin_x_pos <= CONV_STD_LOGIC_VECTOR(980,10);
					count <= "0000000000";
			end if;
		else 
			coin_x_pos <= coin_x_pos - coin_x_motion;
		end if;
		-- Compute next pipe Y position
		
	end if;
end process Move_coin;

END behavior;
		  