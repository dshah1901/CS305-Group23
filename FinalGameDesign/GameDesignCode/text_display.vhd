library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity text_display is 
	port(
		clk_25Mhz																								: in std_logic;
		pixel_row, pixel_column 																: in std_logic_vector (9 downto 0);
		start_screen, stat_screen, death_show   								: in std_logic ;
		text_on : out std_logic
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
		-- Initial Screen
			if(start_screen = '1') then
				if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 512)) then -- TRAIN
					   font_col <= pixel_column(5 downto 3); -- To change the font size
						font_row <= pixel_row(5 downto 3);
						if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 192)) then 
							character_address <= conv_std_logic_vector(20,6); -- T
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (192 <= pixel_column) and (pixel_column < 256)) then 
							character_address <= conv_std_logic_vector(18,6); -- R
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (256 <= pixel_column) and (pixel_column < 320)) then 
							character_address <= conv_std_logic_vector(1,6); -- A
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (320 <= pixel_column) and (pixel_column < 384)) then 
							character_address <= conv_std_logic_vector(9,6); -- I
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (384 <= pixel_column) and (pixel_column < 449)) then 
							character_address <= conv_std_logic_vector(14,6); -- N
							charOn <= '1';
						else
							character_address <= conv_std_logic_vector(32,6); -- Space 
							charOn <= '0';
						end if;	
				end if;
				if ((192 <= pixel_row) and (pixel_row < 256) and (128 <= pixel_column) and (pixel_column < 576)) then -- [LEFT CLICK]
						font_col <= pixel_column(4 downto 2); -- To change the font size
						font_row <= pixel_row(4 downto 2);
						if ((192 <= pixel_row) and (pixel_row < 224) and (192 <= pixel_column) and (pixel_column < 224)) then 
							character_address <= conv_std_logic_vector(91,6); -- [
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (224 <= pixel_column) and (pixel_column < 256)) then 
							character_address <= conv_std_logic_vector(12,6); -- L
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (256 <= pixel_column) and (pixel_column < 288)) then 
							character_address <= conv_std_logic_vector(5,6); -- E
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (288 <= pixel_column) and (pixel_column < 320)) then 
							character_address <= conv_std_logic_vector(6,6); -- F
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (320 <= pixel_column) and (pixel_column < 352)) then 
							character_address <= conv_std_logic_vector(20,6); -- T
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (352 <= pixel_column) and (pixel_column < 384)) then 
							character_address <= conv_std_logic_vector(32,6); -- Space 
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (384 <= pixel_column) and (pixel_column < 416)) then 
							character_address <= conv_std_logic_vector(3,6); -- C
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (416 <= pixel_column) and (pixel_column < 448)) then 
							character_address <= conv_std_logic_vector(12,6); -- L
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (448 <= pixel_column) and (pixel_column < 480)) then 
							character_address <= conv_std_logic_vector(9,6); -- I
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (480 <= pixel_column) and (pixel_column < 512)) then 
							character_address <= conv_std_logic_vector(3,6); -- C
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (512 <= pixel_column) and (pixel_column < 544)) then 
							character_address <= conv_std_logic_vector(11,6); -- K
							charOn <= '1';
						elsif ((192 <= pixel_row) and (pixel_row < 224) and (544 <= pixel_column) and (pixel_column < 576)) then 
							character_address <= conv_std_logic_vector(93,6); -- ]
							charOn <= '1';
						else
							character_address <= conv_std_logic_vector(32,6); -- Space 
							charOn <= '0';
						end if;
				end if;
				if ((256 <= pixel_row) and (pixel_row < 320) and (128 <= pixel_column) and (pixel_column < 512)) then -- GAME
					font_col <= pixel_column(5 downto 3); -- To change the font size
					font_row <= pixel_row(5 downto 3);
					if ((256 <= pixel_row) and (pixel_row < 320) and (128 <= pixel_column) and (pixel_column < 192)) then 
						character_address <= conv_std_logic_vector(7,6); -- G
						charOn <= '1';
					elsif ((256 <= pixel_row) and (pixel_row < 320) and (192 <= pixel_column) and (pixel_column < 256)) then 
						character_address <= conv_std_logic_vector(1,6); -- A
						charOn <= '1';
					elsif ((256 <= pixel_row) and (pixel_row < 320) and (256 <= pixel_column) and (pixel_column < 320)) then 
						character_address <= conv_std_logic_vector(13,6); -- M
						charOn <= '1';
					elsif ((256 <= pixel_row) and (pixel_row < 320) and (320 <= pixel_column) and (pixel_column < 384))then 
						character_address <= conv_std_logic_vector(5,6); -- E
						charOn <= '1';
					else
						character_address <= conv_std_logic_vector(32,6); -- Space 
						charOn <= '0';
					end if;
				end if;
				if ((320 <= pixel_row) and (pixel_row < 352) and (128 <= pixel_column) and (pixel_column < 608)) then -- [RIGHT CLICK]
						font_col <= pixel_column(4 downto 2); -- To change the font size
						font_row <= pixel_row(4 downto 2);
						if ((320 <= pixel_row) and (pixel_row < 352) and (192 <= pixel_column) and (pixel_column < 224)) then 
							character_address <= conv_std_logic_vector(91,6); -- [
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (224 <= pixel_column) and (pixel_column < 256)) then 
							character_address <= conv_std_logic_vector(18,6); -- R
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (256 <= pixel_column) and (pixel_column < 288)) then 
							character_address <= conv_std_logic_vector(9,6); -- I
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (288 <= pixel_column) and (pixel_column < 320)) then 
							character_address <= conv_std_logic_vector(7,6); -- G
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (320 <= pixel_column) and (pixel_column < 352)) then 
							character_address <= conv_std_logic_vector(8,6); -- H
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (352 <= pixel_column) and (pixel_column < 384)) then 
							character_address <= conv_std_logic_vector(20,6); -- T
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (384 <= pixel_column) and (pixel_column < 416)) then 
							character_address <= conv_std_logic_vector(32,6); -- Space
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (416 <= pixel_column) and (pixel_column < 448)) then 
							character_address <= conv_std_logic_vector(3,6); -- C
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (448 <= pixel_column) and (pixel_column < 480)) then 
							character_address <= conv_std_logic_vector(12,6); -- L
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (480 <= pixel_column) and (pixel_column < 512)) then 
							character_address <= conv_std_logic_vector(9,6); -- I
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (512 <= pixel_column) and (pixel_column < 544)) then 
							character_address <= conv_std_logic_vector(3,6); -- C
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (544 <= pixel_column) and (pixel_column < 576)) then 
							character_address <= conv_std_logic_vector(11,6); -- K
							charOn <= '1';
						elsif ((320 <= pixel_row) and (pixel_row < 352) and (576 <= pixel_column) and (pixel_column < 608)) then 
							character_address <= conv_std_logic_vector(93,6); -- ]
							charOn <= '1';
						else
							character_address <= conv_std_logic_vector(32,6); -- Space 
							charOn <= '0';
						end if;
				end if;
			elsif(stat_screen = '1') then
					if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 512)) then -- TRAIN
					   font_col <= pixel_column(5 downto 3); -- To change the font size
						font_row <= pixel_row(5 downto 3);
						if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 192)) then 
							character_address <= conv_std_logic_vector(32,6); -- T
							charOn <= '1';
						else
							character_address <= conv_std_logic_vector(32,6); -- Space 
							charOn <= '0';
						end if;	
				end if;
			elsif(death_show =  '1') then
				if ((128 <= pixel_row) and (pixel_row < 192) and (192 <= pixel_column) and (pixel_column < 512)) then -- TRAIN
					   font_col <= pixel_column(5 downto 3); -- To change the font size
						font_row <= pixel_row(5 downto 3);
						if ((128 <= pixel_row) and (pixel_row < 192) and (192 <= pixel_column) and (pixel_column < 256)) then 
							character_address <= conv_std_logic_vector(7,6); -- G
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (256 <= pixel_column) and (pixel_column < 320)) then 
							character_address <= conv_std_logic_vector(1,6); -- A
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (320 <= pixel_column) and (pixel_column < 384)) then 
							character_address <= conv_std_logic_vector(13,6); -- M
							charOn <= '1';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (384 <= pixel_column) and (pixel_column < 448)) then 
							character_address <= conv_std_logic_vector(5,6); -- E
							charOn <= '1';
						else
							character_address <= conv_std_logic_vector(32,6); -- Space 
							charOn <= '0';
						end if;	
				end if;
				if ((192 <= pixel_row) and (pixel_row < 256) and (192 <= pixel_column) and (pixel_column < 512)) then -- GAME
					font_col <= pixel_column(5 downto 3); -- To change the font size
					font_row <= pixel_row(5 downto 3);
					if ((192 <= pixel_row) and (pixel_row < 256) and (192 <= pixel_column) and (pixel_column < 256)) then 
						character_address <= conv_std_logic_vector(15,6); -- O
						charOn <= '1';
					elsif ((192 <= pixel_row) and (pixel_row < 256) and (256 <= pixel_column) and (pixel_column < 320)) then 
						character_address <= conv_std_logic_vector(22,6); -- V
						charOn <= '1';
					elsif ((192 <= pixel_row) and (pixel_row < 256) and (256 <= pixel_column) and (pixel_column < 320)) then 
						character_address <= conv_std_logic_vector(5,6); -- E
						charOn <= '1';
					elsif ((192 <= pixel_row) and (pixel_row < 256) and (320 <= pixel_column) and (pixel_column < 384))then 
						character_address <= conv_std_logic_vector(18,6); -- R
						charOn <= '1';
					else
						character_address <= conv_std_logic_vector(32,6); -- Space 
						charOn <= '0';
					end if;
				end if;
			end if;
		end process;

		text_on <= rom_mux_output and charOn;
end architecture;