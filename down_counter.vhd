library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
   port( Clock_enable_B: in std_logic;
 	 Clock: in std_logic;
 	 Reset: in std_logic;
 	 Output: out std_logic_vector(0 to 3));
end Counter;
 
architecture Behavioral of Counter is
   signal temp: std_logic_vector(0 to 3);
begin   process(Clock,Reset)
   begin
      if Reset='1' then
         temp <= "1001";
      elsif(rising_edge(Clock)) then
         if Clock_enable_B='0' then
            if temp="0000" then
               temp<="1001";
            else
               temp <= temp - 1;
            end if;
         end if;
      end if;
   end process;
   Output <= temp;
end Behavioral;