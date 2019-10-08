
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY window_pointer IS
	PORT (
		clk : IN std_logic;
		input : IN std_logic_vector(5 DOWNTO 0);
		wpadd : IN std_logic;
		wpreset : IN std_logic;
		output : OUT std_logic_vector(5 DOWNTO 0)
	);
END window_pointer;

ARCHITECTURE behavioral OF window_pointer IS
	SIGNAL temp1 : std_logic_vector(5 DOWNTO 0);
	SIGNAL temp2 : std_logic_vector(5 DOWNTO 0);
BEGIN
	PROCESS (CLK)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (wpreset = '1') THEN
				output <= "000000";
			ELSE
				IF (wpadd = '1') THEN
					temp2 <= std_logic_vector(unsigned(temp1) + unsigned(input));
					temp1 <= temp2;
				END IF;
			END IF;
			output <= temp1;
		END IF;
	END PROCESS;
END behavioral;