LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;



Entity state_tracker is 
	port(clk,death,mouse_click,mode : in std_logic;
		score : in std_logic_vector(9 downto 0);
		enable,reset : out std_logic  );

end entity state_tracker;

architecture beh of state_tracker is
type state_type is (s0, s1, s2, s3, s4, s5, s6);
signal state: state_type := s0;
signal next_state: state_type;

begin

process (clk)

begin
	if (rising_edge(clk) then
		if (

end process;

process (state)
begin
	case state is 
		when s0 =>
			enable <= '0'
			
		when s1 =>

		when s2 =>

		when s3 =>

		when s4 =>
		when s5 =>
  		when s6 =>


end beh;