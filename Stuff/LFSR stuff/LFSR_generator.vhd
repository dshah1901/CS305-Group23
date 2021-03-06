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
  signal reg : std_logic_vector(4 downto 1);
  begin
    lfsr <=  reg(4 downto 1);
    process (clk, reset)
      begin
        if (reset = '1') then
          reg <= seed;
        elsif rising_edge(clk) then
          reg(4) <= reg(1);
          reg(3) <= reg(4) xor reg(1);
          reg(2) <= reg(3);
          reg(1) <= reg(2);
        end if;
      end process;   
end behaviour;