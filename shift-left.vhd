
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shiftleft is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0));
end shiftleft;

architecture Behavioral of shiftleft is
begin
            B(15 downto 1) <= A(14 downto 0); 
            B(0) <= A(15);    
    

  end Behavioral;
         
            




