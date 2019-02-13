LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

	ENTITY count IS
		GENERIC(n: positive := 3);
		PORT( clk: IN std_logic;
		        state:IN std_logic_vector (1 DOWNTO 0);
				
				d_out:	OUT std_logic_vector (n-1 DOWNTO 0));
	END ENTITY count;
	ARCHITECTURE behav OF count IS
		SIGNAL counter:	 std_logic_vector  (n-1 DOWNTO 0):="000";
             
                
	BEGIN
	ct:	PROCESS (state,clk) IS BEGIN
			IF state = "11"	THEN --- Reset
				counter <= (OTHERS => '0');
			ELSIF state = "00" THEN --- Stay the Same
				counter <= counter;
			ELSIF state = "10" THEN  --- Increment
				if counter = "111" then
					counter <=counter ;
				else 
			    counter <= counter + 1;
				end if ;
			ELSE
				
					if counter = "000" then
					counter <=counter ;
				else 
			    counter <= counter - 1;
				end if ;
			END IF;
	END PROCESS ct;
	d_out <= counter;
END ARCHITECTURE behav;