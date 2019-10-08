
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity andComp is
    Port ( Rs : in  STD_LOGIC_VECTOR (15 downto 0);
           Rd : in  STD_LOGIC_VECTOR (15 downto 0);
           aluOut : out  STD_LOGIC_VECTOR (15 downto 0));
end andComp;

architecture Behavioral of andComp is
  begin
    
    process(Rs,Rd)
      begin
     for i in  0 to 15 loop 
     aluOut(i)<=Rs(i) and Rd(i);
    end loop;

  end process;
end behavioral;
  
  
  
