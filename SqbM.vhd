LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
entity Sbqm is
port (
  CLK              : in  std_logic;
  RESET            : in  std_logic;
  Sensor_Input1     : in  std_logic_VECTOR(0 DOWNTO 0);
  Sensor_Input2     : in  std_logic_VECTOR(0 DOWNTO 0);
  Tcount     : in  std_logic_VECTOR(1 DOWNTO 0);
  Enable_rom: in std_logic;
  Wtime_segment : out STD_LOGIC_VECTOR (13 downto 0);
 Pcount_segment : out STD_LOGIC_VECTOR (6 downto 0));
end Sbqm;
ARCHITECTURE sbqm OF sbqm IS 
SIGNAL IN1_SIGNAL :std_logic_vector (0 DOWNTO 0);
SIGNAL IN2_SIGNAL :std_logic_vector(0 DOWNTO 0) ;
SIGNAL Sensor_out_SIGNAL :std_logic_vector(1 DOWNTO 0) ;
SIGNAL fsm_out_SIGNAL :std_logic_vector(1 DOWNTO 0) ;
SIGNAL count_out_SIGNAL :std_logic_vector(2 DOWNTO 0) ;
SIGNAL segment_in_SIGNAL :std_logic_vector(3 DOWNTO 0);
SIGNAL rom_in_SIGNAL :std_logic_vector(4 DOWNTO 0);
SIGNAL rom_out_SIGNAL :std_logic_vector(7 DOWNTO 0);
component Sensors
port (
  CLK              : in  std_logic;
  RESET            : in  std_logic;
  IN1     : in  std_logic_VECTOR(0 DOWNTO 0);
  IN2     : in  std_logic_VECTOR(0 DOWNTO 0);
  OUT1      : out std_logic_VECTOR(1 DOWNTO 0));
end component Sensors;
component count IS
		GENERIC(n: positive := 3);
		PORT( clk: IN std_logic;
		        state:IN std_logic_vector (1 DOWNTO 0);
				
				d_out:	OUT std_logic_vector (n-1 DOWNTO 0));
	END component count;
 component fsm is 
	port ( clk: in std_logic;	
		input: in std_logic_vector (1 downto 0) ; --output sensor
		output: out std_logic_vector(1 downto 0)); --input counter
	end component fsm;
component rom is 
		generic ( n:	integer :=5;
			  m:	integer :=8);
		port( addr: in std_logic_vector (n-1 downto 0);
		      enable : in std_logic ;
		      data: out std_logic_vector (m-1 downto 0));
	end component rom;
	component bcd_7segment is
	Port ( BCDin : in STD_LOGIC_VECTOR (3 downto 0);
	Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
	end component bcd_7segment;
component seven_seg is
		Port ( BCDin : in STD_LOGIC_VECTOR (7 downto 0);
		Seven_Segment : out STD_LOGIC_VECTOR (13 downto 0));
		end component seven_seg;
		
	-------------------------
	FOR Sensors1: Sensors USE ENTITY work.Sensors(behav);
	FOR count1: count USE ENTITY work.count(behav);
	FOR fsm1: fsm USE ENTITY work.fsm(mealy_2p);
	FOR rom1: rom USE ENTITY work.rom(function_arch );
	FOR bcd_7segment1: bcd_7segment USE ENTITY work.bcd_7segment(Behavioral);
	FOR seven_seg1: seven_seg USE ENTITY work.seven_seg(Behavioral);
	
	-----------------------
	begin
	IN1_SIGNAL <= Sensor_Input1;
	IN2_SIGNAL <= Sensor_Input2;
	Sensors1: Sensors PORT MAP (CLK,RESET,IN1_SIGNAL,IN2_SIGNAL,Sensor_out_SIGNAL);
	fsm1: fsm PORT MAP (CLK,Sensor_out_SIGNAL,fsm_out_SIGNAL);
	count1: count GENERIC MAP ( n => 3)
                     PORT MAP ( CLK,fsm_out_SIGNAL,count_out_SIGNAL);
	segment_in_SIGNAL<="0"&count_out_SIGNAL;
	bcd_7segment1: bcd_7segment PORT MAP (segment_in_SIGNAL,Pcount_segment);
	rom_in_SIGNAL<=Tcount&count_out_SIGNAL;
	rom1: rom  GENERIC MAP( n => 5, m => 8)
	                 PORT MAP (rom_in_SIGNAL,Enable_rom,rom_out_SIGNAL);
	seven_seg1: seven_seg PORT MAP (rom_out_SIGNAL,Wtime_segment);
	end architecture sbqm;