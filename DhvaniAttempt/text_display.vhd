library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity text_controller is 
	port(
		enable: in std_logic;
		clk_25Mhz : in std_logic;
		pixel_row, pixel_column : in std_logic_vector (9 downto 0);
		state_out: in std_logic_vector(3 downto 0);
		char_data_out : out std_logic;
		sw0 : in std_logic;
		level : in std_logic_vector(1 downto 0);
		pointOnes, pointsTens : in std_logic_vector(3 downto 0)
	);
end entity text_controller;

architecture behaviour of text_controller is
	
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

		character_address <="010100" when ((pixel_column <= std_logic_vector(to_unsigned(16,10))) AND(pixel_row >= std_logic_vector(to_unsigned(400,10)))AND(pixel_row <= std_logic_vector(to_unsigned(462,10))))--T
			else "010010" when ((pixel_column <= std_logic_vector(to_unsigned(32,10)))AND(pixel_row >= std_logic_vector(to_unsigned(400,10)))AND(pixel_row <= std_logic_vector(to_unsigned(462,10))))--R
			else "000001" when ((pixel_column <= std_logic_vector(to_unsigned(48,10)))AND(pixel_row >= std_logic_vector(to_unsigned(400,10)))AND(pixel_row <= std_logic_vector(to_unsigned(462,10))))--A
			else "001001" when ((pixel_column <= std_logic_vector(to_unsigned(64,10)))AND(pixel_row >= std_logic_vector(to_unsigned(400,10)))AND(pixel_row <= std_logic_vector(to_unsigned(462,10))))--I
			else "000101" when ((pixel_column <= std_logic_vector(to_unsigned(80,10)))AND(pixel_row >= std_logic_vector(to_unsigned(400,10)))AND(pixel_row <= std_logic_vector(to_unsigned(462,10))))--N
			else "001110" when ((pixel_column <= std_logic_vector(to_unsigned(96,10)))AND(pixel_row >= std_logic_vector(to_unsigned(400,10)))AND(pixel_row <= std_logic_vector(to_unsigned(462,10))))--space
    ;
		font_row_sel<=pixel_row(3 downto 1);
		font_col_sel<=pixel_column (3 downto 1);
		char_data_out<= '0' when ((pixel_row)<= std_logic_vector(to_unsigned(0,10)) OR ((pixel_row)<= std_logic_vector(to_unsigned(448,10))) OR(pixel_column)>= std_logic_vector(to_unsigned(450,10)))
			else char_data_int;
end architecture;