library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity text_display is 
	port(
		clk_25Mhz : in std_logic;
		pixel_row, pixel_column : in std_logic_vector (9 downto 0);
		red, green, blue: out std_logic
	);
end entity text_display;

architecture behaviour of text_display is	
	component char_rom
		PORT
			(
				character_address	:	in std_logic_vector (5 downto 0);
				font_row, font_col	:	in std_logic_vector (2 downto 0);
				clock				: 	in std_logic ;
				rom_mux_output		:	out std_logic
			);
		end component;

		signal font_row, font_col : std_logic_vector (2 downto 0);
		signal charOn : std_logic;
		signal character_address : std_logic_vector (5 downto 0);
		signal rom_mux_output : std_logic;
		
	begin
	
		char_data:char_rom PORT MAP(
			character_address=> character_address,
			font_row=> font_row,font_col => font_col,
			clock=>clk_25Mhz,
			rom_mux_output=>rom_mux_output
		);

		textDisplay : Process (pixel_row, pixel_column)
		begin
			if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 512)) then -- FLAPPY
						font_col <= pixel_column(5 downto 3); -- To change the font size
						font_row <= pixel_row(5 downto 3);
						if ((128 <= pixel_row) and (pixel_row < 192) and (192 <= pixel_column) and (pixel_column < 256)) then 
							character_address <= conv_std_logic_vector(20,6); -- T
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (256 <= pixel_column) and (pixel_column < 320)) then 
							character_address <= conv_std_logic_vector(18,6); -- R
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (320 <= pixel_column) and (pixel_column < 384)) then 
							character_address <= conv_std_logic_vector(1,6); -- A
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (384 <= pixel_column) and (pixel_column < 448)) then 
							character_address <= conv_std_logic_vector(9,6); -- I
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (448 <= pixel_column) and (pixel_column < 512)) then 
							character_address <= conv_std_logic_vector(14,6); -- N
							charOn <= '1';
						else
							charOn <= '0';
						end if;
			end if;
			if ((192 <= pixel_row) and (pixel_row < 200) and (128 <= pixel_column) and (pixel_column < 512)) then -- FLAPPY
						font_col <= pixel_column(3 downto 1); -- To change the font size
						font_row <= pixel_row(3 downto 1);
						if ((192 <= pixel_row) and (pixel_row < 200) and (192 <= pixel_column) and (pixel_column < 200)) then 
							character_address <= conv_std_logic_vector(20,6); -- T
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 200) and (200 <= pixel_column) and (pixel_column < 208)) then 
							character_address <= conv_std_logic_vector(18,6); -- R
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 200) and (208 <= pixel_column) and (pixel_column < 216)) then 
							character_address <= conv_std_logic_vector(1,6); -- A
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 200) and (216 <= pixel_column) and (pixel_column < 224)) then 
							character_address <= conv_std_logic_vector(9,6); -- I
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 200) and (224 <= pixel_column) and (pixel_column < 232)) then 
							character_address <= conv_std_logic_vector(14,6); -- N
							charOn <= '1';
						else
							charOn <= '0';
						end if;
			end if;
			if ((256 <= pixel_row) and (pixel_row < 320) and (128 <= pixel_column) and (pixel_column < 512)) then -- FLAPPY
					font_col <= pixel_column(5 downto 3); -- To change the font size
					font_row <= pixel_row(5 downto 3);
					if ((256 <= pixel_row) and (pixel_row < 320) and (192 <= pixel_column) and (pixel_column < 256)) then 
						character_address <= conv_std_logic_vector(7,6); -- G
						charOn <= '1';
					elsif ((256 <= pixel_row) and (pixel_row < 320) and (256 <= pixel_column) and (pixel_column < 320)) then 
						character_address <= conv_std_logic_vector(1,6); -- A
						charOn <= '1';
					elsif ((256 <= pixel_row) and (pixel_row < 320) and (320 <= pixel_column) and (pixel_column < 384)) then 
						character_address <= conv_std_logic_vector(13,6); -- M
						charOn <= '1';
					elsif ((256 <= pixel_row) and (pixel_row < 320) and (384 <= pixel_column) and (pixel_column < 448)) then 
						character_address <= conv_std_logic_vector(5,6); -- E
						charOn <= '1';
					else
						charOn <= '0';
					end if;
			end if;
		end process;

		red <= '0' OR (charOn AND rom_mux_output);
		green <=	'0' OR (charOn AND rom_mux_output);
		blue <= '0' OR (charOn AND rom_mux_output);
end architecture;