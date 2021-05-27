library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lfsr_tb is
--  Port ( );
end lfsr_tb;

architecture Behavioral of lfsr_tb is
signal clk_tb : std_logic := '1';
signal rst_tb : std_logic;
signal send : std_logic_vector(3 downto 0) := "0100";
signal outp_tb : std_logic_vector(3 downto 0);
constant clk_period : time := 10 ns;

component lfsr_generator is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           seed                         : in std_logic_vector(3 downto 0);
           lfsr : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin
process
begin
    clk_tb <= not clk_tb;
    wait for clk_period/2;
end process;

process
begin
    rst_tb <= '1';
    wait for 6 ns;
    
    rst_tb <= '0';
    wait for 50 ns;
    rst_tb <= '1';
    wait for 70 ns;
    rst_tb <= '0';
    wait for 200 ns;
end process;

DUT : lfsr_generator port map (clk_tb,rst_tb,send,outp_tb);

end Behavioral;