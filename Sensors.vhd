 library ieee;
use ieee.std_logic_1164.all;

entity Sensors is
port (
  CLK              : in  std_logic;
  RESET            : in  std_logic;
  IN1     : in  std_logic_VECTOR(0 DOWNTO 0);
  IN2     : in  std_logic_VECTOR(0 DOWNTO 0);
  OUT1      : out std_logic_VECTOR(1 DOWNTO 0));
  
end Sensors;

architecture BEHAV of Sensors is
     signal r_input1   : std_logic_VECTOR(0 downto 0);
	  signal r_input2   : std_logic_VECTOR(0 downto 0);
          signal  test : std_logic_VECTOR(0 downto 0); 
	begin
		p_rising_edge_detector : process(CLK,RESET)
		begin
		  if(RESET='1') then
		    r_input1    <= "0";
			r_input2    <= "0";
		 elsif(rising_edge(CLK)) then
		  test <=IN1 Xor IN2;
		       if(test ="1") then
		            r_input1 <= IN1;
			     r_input2 <= IN2;
		       else
                                 r_input1 <= "1";
				  r_input2 <= "1";
                        end if;
		  end if;
		end process p_rising_edge_detector;
		OUT1 <= r_input1 & r_input2;
end BEHAV;
