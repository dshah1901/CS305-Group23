--LFSR_generator
Library IEEE;
Use IEEE.std_logic_1164.all;

entity lfsr_generator is
  port (
    clk, reset          	        : in std_logic;
    seed                         : in std_logic_vector(3 downto 0);
    lfsr                         : out std_logic_vector (3 downto 0));
end lfsr_generator;

architecture behaviour of lfsr_generator is
  signal reg : std_logic_vector(3 downto 0);
  begin
    lfsr <=  reg(3 downto 0);
    process (clk, reset, seed)
      begin
        if (reset = '1') then
          reg <= seed;
        elsif rising_edge(clk) then
          reg(3) <= reg(0);
          reg(2) <= reg(3) xor reg(0);
          reg(1) <= reg(2);
          reg(0) <= reg(1);
        end if;
      end process;   
end behaviour;