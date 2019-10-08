LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std_unsigned.ALL;

ENTITY ALU IS
	PORT (
		A, B : IN std_logic_vector(15 DOWNTO 0);
		B15to0, AandB, AorB, NotB, AaddB, AsubB, AmulB, AcmpB, ShrB, ShlB : IN std_logic;
		zout, cout : OUT std_logic;--zout:becomes one when the ALU?s output is zero
		--cout: becomes one when the ALU?s output has got carry digit
		aluOut : OUT std_logic_vector(15 DOWNTO 0);
		cin : IN std_logic
	);
END ALU;
 
ARCHITECTURE behavioral OF ALU IS
	COMPONENT Addition
		PORT (
			a, b : IN std_logic_vector (15 DOWNTO 0);
			c0 : IN std_logic;
			sum : OUT std_logic_vector (15 DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
 
	COMPONENT subtraction
		PORT (
			a, b : IN std_logic_vector(15 DOWNTO 0);
			cin : IN std_logic;
			sub : OUT std_logic_vector(15 DOWNTO 0);
			cout : OUT std_logic
		);
	END COMPONENT;
 
	COMPONENT andComp
		PORT (
			Rs : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			Rd : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			aluOut : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT orComp
		PORT (
			A : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			aluOut : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT xorComp
		PORT (
			Rs : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			Rd : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			aluOut : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT shiftleft
		PORT (
			A : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		B : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)); 
	END COMPONENT;
 
	COMPONENT shiftright
		PORT (
			Rs : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			Rd : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT comparator
		PORT (
			A : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			zout, cout : OUT STD_LOGIC;
			aluout : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT mulComp
		PORT (
			A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			res : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;

 
	-- component twoscompliment port(A : in std_logic_vector (Nbits-1 downto 0);
	-- aluout : out std_logic_vector (Nbits downto 0));
	-- end component;
 
	SIGNAL add_res, sub_res, and_res, or_res, comp_res, shiftL_res, mul_res, 
	shiftR_res : std_logic_vector(0 TO 15); 
	SIGNAL cout_add, cout_sub, cout_comp : std_logic;
 
BEGIN
	x1 : Addition
	PORT MAP(A, B, cin, add_res, cout_add);
	x2 : Subtraction
	PORT MAP(A, B, cin, sub_res, cout_sub);
	x3 : andComp
	PORT MAP(A, B, and_res);
x4 : orComp
PORT MAP(A, B, or_res);
x5 : mulComp
PORT MAP(A(7 DOWNTO 0), B(7 DOWNTO 0), mul_res);
x6 : comparator
PORT MAP(A, B, zout, cout_comp, comp_res);
x7 : shiftleft
PORT MAP(A, shiftL_res);
x8 : shiftright
PORT MAP(A, shiftR_res);
 
PROCESS (B15to0, AandB, AorB, NotB, AaddB, AsubB, AmulB, AcmpB, ShrB, ShlB)
BEGIN
	IF (B15to0 = '1') THEN
		aluout <= B;
		zout <= '0';
		cout <= '0';
	ELSIF (AaddB = '1') THEN
		aluout <= add_res;
		cout <= cout_add;
		zout <= '0';
 
	ELSIF (AsubB = '1') THEN
		aluout <= sub_res;
		cout <= cout_sub;
		zout <= '0';
 
	ELSIF (AandB = '1') THEN
		aluout <= and_res;
		zout <= '0';
		cout <= '0';

	ELSIF (AorB = '1') THEN
		aluout <= or_res;
		zout <= '0';
		cout <= '0';

	ELSIF (notB = '1') THEN
		aluout <= NOT B;
		zout <= '0';
		cout <= '0';

	ELSIF (AmulB = '1') THEN
		aluout <= mul_res;
		zout <= '0';
		cout <= '0';

	ELSIF (AcmpB = '1') THEN
		aluout <= comp_res;
		cout <= cout_comp;
		zout <= '0';
 
	ELSIF (ShlB = '1') THEN
		aluout <= shiftL_res;
		zout <= '0';
		cout <= '0';

	ELSIF (ShrB = '1') THEN
		aluout <= shiftR_res;
		zout <= '0';
		cout <= '0';
	END IF;
END PROCESS;
END behavioral;