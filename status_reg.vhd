
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity status_reg is
  port(
   clk,Cset,Creset,Zset,Zreset,SRload,Cout,Zout : in std_logic;
    cin,zin : out std_logic);
  end;
  architecture behavioral of status_reg is 
  begin
  process(clk,Cset, Creset, Zset, Zreset,SRload,Cout,Zout)
    begin
      if (clk'event and clk = '1') then
        if(Cset='1')then
         Cin <= '1';
        end if;
        if(Creset ='1') then
         Cin <= '0';
        end if;
        if(Zset ='1')then
         zin <= '1';
        end if;
        if( Zreset ='1') then
         zin <= '0';
        end if;
       if( Srload ='1' )then
        cin<= cout;
        zin <= zout;
       end if;
     end if;
  end process;
end behavioral;

