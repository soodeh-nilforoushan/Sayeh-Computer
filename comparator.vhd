
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_1164.STD_LOGIC.


entity comparator is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           zout,cout: out  STD_LOGIC;
           aluout :out STD_LOGIC_VECTOR (15 downto 0));
           
           
           
end comparator;

architecture behavioral of comparator is
  begin
aluout<=A;
process(A,B)
begin
if (A> B ) then cout<='1';
else cout<='0';
end if;
if (A = B) then zout<='1';
else zout<='0';
end if;
end process;
end behavioral;
      
      
      
      
      


