
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Addition is
  port(a, b :in std_logic_vector (15 downto 0);
        c0:  in std_logic;
       sum : out std_logic_vector (15 downto 0);
       cout: out std_logic);
     
     end Addition;
     
     
architecture behavioral of Addition is
    signal result: std_logic_vector (16 downto 0);
  begin
    result <= ('0' & a) + ('0' & b) + c0 ;
    sum<= result(15 downto 0);
    cout<= result (16);
    
  end behavioral;
  