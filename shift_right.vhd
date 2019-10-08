
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shiftright is
    Port ( Rs : in  STD_LOGIC_VECTOR (15 downto 0);
           Rd : out  STD_LOGIC_VECTOR (15 downto 0));
end shiftright;

architecture Behavioral of shiftright is
begin
            Rd(14 downto 0) <= Rs(15 downto 1); 
            Rd(15) <= Rs(0);    
    

  end Behavioral;
         
            

