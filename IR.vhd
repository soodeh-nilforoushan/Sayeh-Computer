

Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity IR  is
  port(clk,IRload:in std_logic;
       dataBus: in std_logic_vector(15 downto 0);
       IRout:out std_logic_vector(15 downto 0));
     end IR;
     
 architecture Behavioral of IR is
    begin
    process(clk)
      begin
        if(clk ='1') then 
        if(IRload ='1') then
        IRout <= dataBus;
      end if;
    end if;
  end process;
  end Behavioral;
   
