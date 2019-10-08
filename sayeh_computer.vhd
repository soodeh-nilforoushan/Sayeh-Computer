library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sayeh_computer is
  port(clk,External_reset:in std_logic;
    DataBus:inout std_logic_vector(0 to 15));
    
  end entity;
  
  architecture Behavioral of sayeh_computer is
    
    component memory port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : inout std_logic_vector (15 downto 0);
		memdataready : out std_logic);
		end component;
		
		component controller Port (external_reset,clk,memDataReady,cout,zout:in std_logic;
      instruction:in std_logic_vector(0 to 15);
      B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,
       wpadd,wpreset, RFLwrite, RFHwrite,IRload,
       ResetPC, PCplusI, PCplus1, RplusI, Rplus0,EnablePC,AlUout_on_Databus,
       Rs_on_AddressUnitRSide, Rd_on_AddressUnitRside,Address_on_databus,
       Cset, Creset, Zset, Zreset, SRload ,readMem,writeMem:out std_logic  );
end component;
 
 component datapath is
  port(clk,B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,
       wpadd,wpreset, RFLwrite, RFHwrite,IRload,
       ResetPC, PCplusI, PCplus1, RplusI, Rplus0,EnablePC,
       Rs_on_AddressUnitRSide, Rd_on_AddressUnitRSide,
       Cset, Creset, Zset, Zreset,SRload ,
        Address_on_Databus, ALU_on_Databus:in  std_logic;
       cout,zout:out std_logic;
       addressBus,instruction:out std_logic_vector(0 to 15) ;
       dataBus:inout std_logic_vector(15 downto 0) );
 end component;


signal B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,
       wpadd,wpreset, RFLwrite, RFHwrite,IRload,
       ResetPC, PCplusI, PCplus1, RplusI, Rplus0,EnablePC,
       Rs_on_AddressUnitRSide, Rd_on_AddressUnitRSide,
       Cset, Creset, Zset, Zreset,SRload ,
        Address_on_Databus, ALUout_on_Databus,cout,zout,memDataReady,readMem,WriteMem: std_logic;
    signal addressBus,instruction:std_logic_vector(15 downto 0);
      begin
  x1:memory port map(clk, readmem, writemem,
		addressbus,
		databus ,
		memdataready);
	x2:datapath port map(clk ,B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,
       wpadd,wpreset, RFLwrite, RFHwrite,IRload,
       ResetPC, PCplusI, PCplus1, RplusI, Rplus0,EnablePC,
       Rs_on_AddressUnitRSide, Rd_on_AddressUnitRSide,
       Cset, Creset, Zset, Zreset,SRload ,
        Address_on_Databus, ALUout_on_Databus,
       cout,zout,
       addressBus,instruction,
     dataBus);
x3:controller port map(external_reset,clk,memDataReady,cout,zout,
      instruction,
      B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,
       wpadd,wpreset, RFLwrite, RFHwrite,IRload,
       ResetPC, PCplusI, PCplus1, RplusI, Rplus0,EnablePC,AlUout_on_Databus,
       Rs_on_AddressUnitRSide, Rd_on_AddressUnitRside,Address_on_databus,
       Cset, Creset, Zset, Zreset, SRload ,readMem,writeMem  );
  end behavioral;