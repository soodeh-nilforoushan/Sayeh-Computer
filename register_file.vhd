
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
--use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.ALL;

ENTITY RegisterFile IS
	PORT (
		input : IN std_logic_vector(15 DOWNTO 0);
		Rd, Rs : OUT std_logic_vector(15 DOWNTO 0);
		wp : IN std_logic_vector(5 DOWNTO 0);
		clk, RFLwrite, RFHwrite : IN std_logic;
		left, right : IN std_logic_vector(1 DOWNTO 0) 
	);
 
END RegisterFile;
ARCHITECTURE Behavioral OF RegisterFile IS
	SIGNAL leftaddressout, rightaddressout : std_logic_vector(5 DOWNTO 0);
	SIGNAL m1 : std_logic_vector(5 DOWNTO 0);
	SIGNAL m2 : std_logic_vector(5 DOWNTO 0);
	TYPE registers IS ARRAY (0 TO 63) OF std_logic_vector (15 DOWNTO 0);
 
	SIGNAL reg : registers;
	SIGNAL temp : std_logic_vector(15 DOWNTO 0);
BEGIN
	m1 <= "0000" & left;
	m2 <= "0000" & right;
	leftaddressout <= std_logic_vector(unsigned(wp) + unsigned(m1));--inja miad wp ro ba 2 bit por arzeshmajool paini jam mikone va adress register az 0 ta 63 ro mide
	--bad meghdaro az register mikhooe vamirize too left ya RD
	--ke inja adrese reg maghsad(D) entekhab shod
	rightaddressout <= std_logic_vector(unsigned(wp) + unsigned(m2));--inja adresse reg mabda(S) entekhab shod.
 
	PROCESS (clk)
	BEGIN
		IF (clk'EVENT AND clk = '1') THEN
			IF (RFLwrite = '1' AND RFHwrite = '1') THEN
				temp <= input;
				-- temp <= reg(to_integer(unsigned(leftaddressout)));--meghdare reg destination ra mirizim to temp
			ELSE
				IF (RFLwrite = '1' AND RFHwrite = '0') THEN
					temp(7 DOWNTO 0) <= input(7 DOWNTO 0);
				ELSE IF (RFHwrite = '1' AND RFLwrite = '0') THEN
					temp(15 DOWNTO 8) <= input(15 DOWNTO 8);
				END IF;
			END IF;
		END IF;
		reg(to_integer(unsigned(leftaddressout))) <= temp;
	END IF;
	END PROCESS;
 
	Rd <= reg(to_integer(unsigned(leftaddressout)));--meghdar e reg ro rikhtam too Rd
	Rs <= reg(to_integer(unsigned(rightaddressout)));
 
END Behavioral;