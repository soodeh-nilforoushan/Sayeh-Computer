library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mulComp is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           res : out  STD_LOGIC_VECTOR (15 downto 0));
end mulComp;

architecture Behavioral of mulComp is
  begin
    
    res<=A*B;
  end Behavioral; 


