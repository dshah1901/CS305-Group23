LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;



ENTITY pipes IS
	generic( pipe_num :   std_logic_vector(1 DOWNTO 0):= "00");
	PORT
		( clk, vert_sync, reset,pb2								: IN std_logic;
		  pixel_row, pixel_column							: IN std_logic_vector(9 DOWNTO 0);
		  difficulty											: in std_logic_vector(1 DOWNTO 0);
		  pipe_on					 							: OUT std_logic;
		  gap_bot_row, gap_left_col						: out std_logic_vector(10 downto 0));		
END pipes;

architecture behavior of pipes is

component LFSR_generator
port (clk, reset		: in std_logic;
seed						: in std_logic_vector(3 downto 0);
lfsr 						: out std_logic_vector(3 downto 0));
end component LFSR_generator;

SIGNAL pipes_on,gap_on			: std_logic;
SIGNAL wedge 					: std_logic_vector(9 DOWNTO 0);
SIGNAL height, gap_height					: std_logic_vector(9 downto 0);  
SIGNAL pipes_y_pos, pipes_x_pos, gap_y_pos	: std_logic_vector(9 DOWNTO 0);
SIGNAL pipe_x_motion			: std_logic_vector(9 DOWNTO 0);
Signal send						: std_logic_vector(3 downto 0) := "1110";
signal lfsr1 						: std_logic_vector(3 downto 0);

BEGIN           

random: LFSR_generator
port map (Clk => clk, reset => '1', seed => send, lfsr => lfsr1);

wedge <= CONV_STD_LOGIC_VECTOR(30,10);
height <= CONV_STD_LOGIC_VECTOR(440,10);
gap_height <= CONV_STD_LOGIC_VECTOR(80,10);
-- pipe_x_pos and pipe_y_pos show the (x,y) for the centre of ball
pipes_y_pos <= CONV_STD_LOGIC_VECTOR(40,10);


pipes_on <= '1' when ( ('0' & pipes_x_pos <= pixel_column+ wedge + wedge) and ('0' & pixel_column <= pipes_x_pos ) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipes_y_pos <= pixel_row + height) and ('0' & pixel_row <= pipes_y_pos + height) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
gap_on <= '1' when (('0' & pipes_x_pos <= pixel_column+ wedge + wedge) and ('0' & pixel_column <= pipes_x_pos )
					and ('0' & gap_y_pos <= pixel_row + gap_height) and ('0' & pixel_row <= gap_y_pos )) else
					'0';

pipe_on <= (pipes_on and not gap_on);
gap_bot_row <= '0' & gap_y_pos + gap_height;
gap_left_col <= '0' & pipes_x_pos;



Move_pipe: process (vert_sync) 
 	
begin
	-- Move pipe once every vertical sync
	if (rising_edge(vert_sync) and pb2 = '1') then
		pipe_x_motion <= CONV_STD_LOGIC_VECTOR(2,10) + ("00000000" & difficulty);
		
		if reset = '1' then
			case pipe_num is
				when "00" => 
				pipes_x_pos <= CONV_STD_LOGIC_VECTOR(480,10);
				gap_y_pos <= CONV_STD_LOGIC_VECTOR(400,10);
				send <= "1000";
				when "01" => 
				pipes_x_pos <= CONV_STD_LOGIC_VECTOR(720,10);
				gap_y_pos <= CONV_STD_LOGIC_VECTOR(300,10);
				send <= "0101";
				when "10" => 
				pipes_x_pos <= CONV_STD_LOGIC_VECTOR(900,10);
				gap_y_pos <= CONV_STD_LOGIC_VECTOR(200,10);
				send <= "1101";
				when others => 
				pipes_x_pos <= CONV_STD_LOGIC_VECTOR(950,10);
				send <= "0010";
			end case;
		-- Bounce off top or bottom of the scree
		elsif (('0' & pipes_x_pos <= CONV_STD_LOGIC_VECTOR(0,11))) then
			case lfsr1 is
				when "0001" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(150,10);
				when "0010" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(380,10);
				when "0011" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(190,10);
				when "0100" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(240,10);
				when "0101" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(320,10);
				when "0110" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(140,10);
				when "0111" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(400,10);
				when "1000" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(160,10);
				when "1001" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(200,10);
				when "1010" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(280,10);
				when "1011" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(360,10);
				when "1100" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(120,10);
				when "1101" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(340,10);
				when "1110" => gap_y_pos <= CONV_STD_LOGIC_VECTOR(260,10);
				when others => gap_y_pos <= CONV_STD_LOGIC_VECTOR(180,10);
			end case;
			if (send >= "1111") then
				send <= "0001";
			else
				send <= send + "0001";
			end if;
			pipes_x_pos <= CONV_STD_LOGIC_VECTOR(720,10);
		else 
			pipes_x_pos <= pipes_x_pos - pipe_x_motion;
		end if;
		
		-- Compute next pipe Y position
		
	end if;
end process Move_pipe;

END behavior;