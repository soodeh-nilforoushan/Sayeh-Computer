
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity  subtraction is
  port (a,b :in  std_logic_vector(15 downto 0);
        cin: in  std_logic;
        sub :out  std_logic_vector(15 downto 0);
        cout :out std_logic);
        
      end subtraction;
      
  architecture behavioral of  subtraction is
 signal res:std_logic_vector(15 downto 0);
 begin
    res<=a - b- cin;
    cout<='1' when a(15)/=b(15)
    and res(15)/=a(15) 
    else '0';
      sub<=res;
end behavioral;


