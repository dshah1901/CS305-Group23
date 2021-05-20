library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity text_display is 
	port(
		--enable: in std_logic;
		clk_25Mhz : in std_logic;
		pixel_row, pixel_column : in std_logic_vector (9 downto 0);
		char_data_out : out std_logic
	);
end entity text_display;

architecture behaviour of text_display is	
	component char_rom
		port
			(
				character_address	:	in std_logic_vector (5 downto 0);
				font_row, font_col	:	in std_logic_vector (2 downto 0);
				clock				: 	in std_logic ;
				rom_mux_output		:	out std_logic
			);
		end component;
		signal font_row_sel, font_col_sel : std_logic_vector (2 downto 0);
		signal character_address : std_logic_vector (5 downto 0);
		signal char_data_int : std_logic;
		
	begin
	
		char_data:char_rom port map(
			character_address=> character_address,
			font_row=> font_row_sel,font_col => font_col_sel,
			clock=>clk_25Mhz,
			rom_mux_output=>char_data_int
		);
	process(clk, pixel_row, pixel_column)
        begin
         if rising_edge(clk) then
					if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 512)) then -- FLOPPY
						font_col <= pixel_column(5 downto 3);
						font_row <= pixel_row(5 downto 3);
						if ((128 <= pixel_row) and (pixel_row < 192) and (128 <= pixel_column) and (pixel_column < 192)) then 
							character_address <= conv_std_logic_vector(6,6); -- F
							red <= rom_mux;
							green <= '0';
							blue <= '0';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (192 <= pixel_column) and (pixel_column < 256)) then 
							character_address <= conv_std_logic_vector(12,6); -- L
							red <= rom_mux;
							green <= rom_mux;
							blue <= '0';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (256 <= pixel_column) and (pixel_column < 320)) then 
							character_address <= conv_std_logic_vector(1,6); -- A
							red <= '0';
							green <= rom_mux;
							blue <= '0';
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (320 <= pixel_column) and (pixel_column < 384)) then 
							character_address <= conv_std_logic_vector(16,6); -- P
							red <= '0';
							green <= rom_mux;
							blue <= rom_mux;
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (384 <= pixel_column) and (pixel_column < 448)) then 
							character_address <= conv_std_logic_vector(16,6); -- P
							red <= '0';
							green <= '0';
							blue <= rom_mux;
						elsif ((128 <= pixel_row) and (pixel_row < 192) and (448 <= pixel_column) and (pixel_column < 512)) then 
							character_address <= conv_std_logic_vector(25,6); -- Y
							red <= rom_mux;
							green <= '0';
							blue <= rom_mux;
						else
							red <= '0';
							green <= '0';
							blue <= '0';
						end if;
                end if;
            end if;
        end process;
end architecture;