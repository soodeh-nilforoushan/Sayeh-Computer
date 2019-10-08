Library ieee;
use ieee.std_logic_1164.all;


entity datapath is
  port(clk,B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,
       wpadd,wpreset, RFLwrite, RFHwrite,IRload,
       ResetPC, PCplusI, PCplus1, RplusI, Rplus0,EnablePC,
       Rs_on_AddressUnitRSide, Rd_on_AddressUnitRSide,
       Cset, Creset, Zset, Zreset,SRload ,
       Address_on_Databus, ALU_on_Databus:in  std_logic;
       cout,zout:out std_logic;
       addressBus,instruction:out std_logic_vector(15 downto 0) ;
       dataBus:inout std_logic_vector(15 downto 0) );
 end datapath;
 
     architecture behavioral of datapath is
     
    component ALU port (A,B: in std_logic_vector(15 downto 0);
      B15to0,AandB,AorB,NotB,AaddB,AsubB,AmulB,AcmpB,ShrB,ShlB:in std_logic;
      zout,cout: out std_logic;--zout:becomes one when the ALU?s output is zero
                               --cout: becomes one when the ALU?s output has got carry digit
      aluOut: out std_logic_vector(15 downto 0);
      cin   : in  std_logic);
    end component;
    
   component AddressUnit port ( Rside : IN std_logic_vector (15 downto 0);
       Iside : IN std_logic_vector (7 downto 0);
       Address : OUT std_logic_vector (15 downto 0);
       clk, ResetPC, PCplusI, PCplus1 : IN std_logic; 
       RplusI, Rplus0, EnablePC : IN std_logic ); 
  end component;
 
 component RegisterFile  port (input:in std_logic_vector(15 downto 0);
        Rd,Rs:out std_logic_vector(15 downto 0);
        wp :in std_logic_vector(5 downto 0);
        clk,RFLwrite,RFHwrite:in std_logic;
        left,right:in std_logic_vector(1 downto 0) );
   end component;
      
  component IR port (clk,IRload:in std_logic;
       dataBus: in std_logic_vector(15 downto 0);
       IRout:out std_logic_vector(15 downto 0));
     end component;

	component window_pointer PORT (
    clk: in std_logic;
    input : in std_logic_vector(5 downto 0);
    wpadd : in std_logic;
    wpreset : in std_logic;
    output : out std_logic_vector(5 downto 0));
end component;
  
  component status_reg  port(
   clk,Cset,Creset,Zset,Zreset,SRload,Cout,Zout : in std_logic;
    cin,zin : out std_logic);
  end component;
	
	  signal AddressUnitRSideBus,IRout,Address,ALUout:std_logic_vector(15 downto 0);
	  signal RD,RS :std_logic_vector(15 downto 0);
	--  signal LAddress,RAddress:std_logic_vector(1 downto 0);
	  signal wpout:std_logic_vector(5 downto 0);
	  signal SRcin,SRzin,SRcout,SRzout:std_logic;
    
	begin
	  x1:AddressUnit port map(AddressUnitRSideBus,IRout(7 downto 0),Address,clk,
	   ResetPC, PCplusI, PCplus1,  RplusI, Rplus0, EnablePC );
 
    x2: ALU port map(RD,RS,B15to0,AandB,AorB,NotB,AaddB,AsubB,AmulB,AcmpB,ShrB,ShlB,
      SRzout,SRcout,--zout:becomes one when the ALU?s output is zero
                --cout: becomes one when the ALU?s output has got carry digit
      ALUout,SRcin);
  
   
	x3:RegisterFile port map(DataBus,RD,RS,wpout ,
        clk,RFLwrite,RFHwrite,IRout(11 downto 10),IRout(9 downto 8) );
  
   x5:IR port map(clk,IRload,DataBus,IRout);  
       
  x4:status_reg port map(clk,Cset,Creset,Zset,Zreset,SRload,SRcout,SRZout,
    SRcin,SRzin);
    
 
     
  x6:window_pointer port map(clk,IRout(5 downto 0),wpAdd,wpReset,wpOut);
    

	process(Rs_on_AddressUnitRSide,Rd_on_AddressUnitRSide,Address_on_Databus,
	  ALU_on_Databus)
	  begin
if( Rs_on_AddressUnitRSide = '1') then
AddressUnitRSideBus<=RS;
end if;
if(Rd_on_AddressUnitRSide = '1') then
  AddressUnitRSideBus<=RD;
else 
  AddressUnitRSideBus<=(others=>'Z');
end if;
 addressBus<=Address; 

if( Address_on_Databus ='1') then
DataBus<=Address;
end if;
 if(ALU_on_Databus= '1') then
  DataBus<=ALUout;
else 
  DataBus<=(others=>'Z');
end if;
zout<=SRzout;
cout<=SRcout;
instruction<=IRout;
 --  if(shadow='0')then
 --   LAddress<=IRout(10 to 11);
 --  else
 --   LAddress<=IRout(2 to 3);
 --  end if;
   
 -- if(shadow='0')then
 --   RAddress<=IRout(8 to 9);
 --  else
 --   RAddress<=IRout(0 to 1);
 --    end if;
  end process;

end Behavioral;
     
     
       
       

