library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
entity twoscompliment is
      
port(A : in std_logic_vector (15 downto 0);
           aluout : out std_logic_vector (15 downto 0));
end twoscompliment;

architecture behavioral of twoscompliment is
signal temp : std_logic_vector(15 downto 0);
begin
  temp <= not A;
  aluout <= std_logic_vector(unsigned(temp) + 1);
end behavioral;